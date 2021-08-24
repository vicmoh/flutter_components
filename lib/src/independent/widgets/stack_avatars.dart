import 'dart:io';

import 'package:flutter/material.dart';

/// A stack up avatars that is on top of one and another.
/// It is used in the user post card and the event card modal.
/// The avatar stacks of on top each other where you can see a part of other
/// avatar on the side. The first avatar is shown on top, and the avatar below
/// is shift to the right. [imageUrls] is a list of the avatar urls
/// to show. The [imagePlaceholderPath] is the loading image,
/// if it is null it will not show any loading.
class StackAvatars extends StatelessWidget {
  final String imagePlaceholderPath;
  final List<String> imageUrls;
  final EdgeInsetsGeometry padding;
  final double imageSize;
  final int maxAvatarToShow;
  final Color outlineColor;
  final double outlineWeight;
  final double imageOffsetSpacing;
  final bool reverseOffsetSpacing;
  final File imageFile;

  /// A stack up avatars that is on top of one and another.
  /// It is used in the user post card and the event card modal.
  /// The avatar stacks of on top each other where you can see a part of other
  /// avatar on the side. The first avatar is shown on top, and the avatar below
  /// is shift to the right. [imageUrls] is a list of the avatar urls
  /// to show. The [imagePlaceholderPath] is the loading image,
  /// if it is null it will not show any loading.
  /// [imageOffsetSpacing] is the image spacing between each images
  /// when more than 1 images is tracked.
  ///
  /// If [imageFile] is define, it will use image file instead of the url.
  StackAvatars({
    @required this.imageUrls,
    this.imageFile,
    this.imagePlaceholderPath,
    this.padding,
    this.imageSize = 23,
    this.maxAvatarToShow = 3,
    this.outlineWeight = 0,
    this.outlineColor = Colors.transparent,
    this.imageOffsetSpacing = 15,
    this.reverseOffsetSpacing = false,
  });

  /// Circle avatar for profile image
  Widget _avatar({
    String profileImageUrl,
    double offset = 0,
    Color outlineColor,
  }) {
    /// Use this image file if the
    Widget asset;
    if (this.imageFile != null) {
      asset = Image.file(this.imageFile,
          width: imageSize, height: imageSize, fit: BoxFit.cover);
    } else {
      asset = (this.imagePlaceholderPath != null)

          /// causes to have continuous state at the start.
          ? (profileImageUrl == null)
              ? Image.asset(this.imagePlaceholderPath,
                  width: imageSize, height: imageSize, fit: BoxFit.cover)
              : FadeInImage.assetNetwork(
                  image: profileImageUrl,
                  fadeInCurve: Curves.easeIn,
                  fadeOutCurve: Curves.easeIn,
                  fadeInDuration: Duration(milliseconds: 300),
                  fadeOutDuration: Duration(milliseconds: 300),
                  placeholder: this.imagePlaceholderPath,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover)
          : Image.network(profileImageUrl,
              width: imageSize, height: imageSize, fit: BoxFit.cover);
    }

    return Container(
        padding: EdgeInsets.only(left: offset),
        child: Container(

            /// The circle avatar line
            padding: EdgeInsets.all(this.outlineWeight),
            decoration: BoxDecoration(
                color: outlineColor ?? this.outlineColor,
                shape: BoxShape.circle),

            /// The avatar image
            child: ClipOval(child: asset)));
  }

  /// Main content with stack
  Widget _mainContent(BuildContext context) {
    double offset = 0;
    List<Widget> images = [];
    int count = 0;

    if (imageFile == null) {
      for (var each in this.imageUrls) {
        Color color = each != null ? this.outlineColor : Colors.transparent;
        images.add(_avatar(
            profileImageUrl: each, offset: offset, outlineColor: color));
        offset += this.imageOffsetSpacing;
        count++;
        if (this.maxAvatarToShow == count) break;
      }
    } else {
      images.add(_avatar(
          offset: offset,
          outlineColor: this.outlineColor ?? Colors.transparent));
    }

    /// Return the main Content
    if ((images.length == 0 || this.imageUrls == null) &&
        this.imagePlaceholderPath == null) {
      return Container(
          width: this.imageSize,
          height: this.imageSize,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.withAlpha(100), shape: BoxShape.circle),
          child: Container(
              child: Icon(Icons.person,
                  color: Colors.white,
                  size: (this.imageSize - 20 < 1) ? 1 : this.imageSize - 20)));
    } else
      return Container(
          child: Stack(
              children:
                  reverseOffsetSpacing ? images : images.reversed.toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: this.padding, child: this._mainContent(context));
  }
}
