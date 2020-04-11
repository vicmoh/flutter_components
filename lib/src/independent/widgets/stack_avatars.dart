import 'package:flutter/material.dart';

class StackAvatars extends StatelessWidget {
  final String imagePlaceholderPath;
  final List<String> imageUrls;
  final EdgeInsetsGeometry padding;
  final double imageSize;
  final int maxAvatarToShow;
  final Color outlineColor;
  final double outlineWeight;
  final double imageOffsetSpacing;

  /// A stack up avatars that is on top of one and another.
  /// It is used in the user post card and the event card modal.
  /// The avatar stacks of on top each other where you can see a part of other
  /// avatar on the side. The first avatar is shown on top, and the avatar below
  /// is shift to the right. [imageUrls] is a list of the avatar urls
  /// to show. The [imagePlaceholderPath] is the loading image,
  /// if it is null it will not show any loading.
  StackAvatars({
    @required this.imageUrls,
    this.imagePlaceholderPath,
    this.padding,
    this.imageSize = 23,
    this.maxAvatarToShow = 3,
    this.outlineWeight = 1,
    this.outlineColor = Colors.grey,
    this.imageOffsetSpacing = 15,
  });

  /// Circle avatar for profile image
  Widget _avatar(
    String profileImageUrl, {
    double offset = 0,
    Color outlineColor,
  }) {
    return Container(
        padding: EdgeInsets.only(left: offset),
        child: Container(
            // The circle avatar line
            padding: EdgeInsets.all(this.outlineWeight),
            decoration: BoxDecoration(
                color: outlineColor ?? this.outlineColor,
                borderRadius: BorderRadius.circular(90)),
            // The avatar image
            child: ClipOval(
                child: (this.imagePlaceholderPath != null)
                    // TODO: For some reason asset network causes to have continuous state at the start.
                    ? (profileImageUrl == null)
                        ? Image.asset(this.imagePlaceholderPath,
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.cover)
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
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover))));
  }

  /// Main content with stack
  Widget _mainContent(BuildContext context) {
    double offset = 0;
    List<Widget> images = [];
    int count = 0;
    for (var each in this.imageUrls) {
      Color color = each != null ? this.outlineColor : Colors.transparent;
      images.add(this._avatar(each, offset: offset, outlineColor: color));
      offset += this.imageOffsetSpacing;
      count++;
      if (this.maxAvatarToShow == count) break;
    }
    // Return the main Content
    if (images.length == 0 || this.imageUrls == null)
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
    else
      return Container(child: Stack(children: images));
  }

  /// Build the stack avatars
  @override
  Widget build(BuildContext context) {
    return Container(padding: this.padding, child: this._mainContent(context));
  }
}
