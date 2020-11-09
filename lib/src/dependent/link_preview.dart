import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Link preview to the preview of the URL.
class LinkPreview extends StatelessWidget {
  /// Link preview to the preview of the URL.
  LinkPreview({
    Key key,
    @required this.url,
    @required this.onTap,
    this.domain,
    this.title,
    this.description,
    BorderRadius borderRadius,
    BorderRadius imageBorderRadius,
    BorderRadius inkWellBorderRadius,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0,
    this.linkStyle,
    this.titleStyle,
    this.descriptionStyle,
    this.isLinkAtBottom = false,
    this.padding = const EdgeInsets.all(0),
    this.imagePadding = const EdgeInsets.only(bottom: 10),
    this.titlePadding = const EdgeInsets.only(bottom: 10),
    this.descriptionPadding = const EdgeInsets.only(bottom: 10),
    this.linkPadding = const EdgeInsets.only(bottom: 10),
    this.textPadding = const EdgeInsets.symmetric(horizontal: 15),
    this.imageFit,
    this.height,
    this.width,
  })  : this.borderRadius = borderRadius ?? BorderRadius.circular(0),
        this.imageBorderRadius = imageBorderRadius ?? BorderRadius.circular(0),
        this.inkWellBorderRadius =
            inkWellBorderRadius ?? BorderRadius.circular(0),
        assert(url != null),
        assert(onTap != null),
        super(key: key);

  LinkPreview.bubble({
    Key key,
    @required this.url,
    @required this.onTap,
    this.domain,
    this.title,
    this.description,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.elevation = 0,
    double radius = 20,
    this.linkStyle,
    this.titleStyle,
    this.descriptionStyle,
    this.isLinkAtBottom = false,
    this.imagePadding = const EdgeInsets.only(bottom: 10),
    this.titlePadding = const EdgeInsets.only(bottom: 10),
    this.descriptionPadding = const EdgeInsets.only(bottom: 10),
    this.linkPadding = const EdgeInsets.only(bottom: 10),
    this.textPadding = const EdgeInsets.symmetric(horizontal: 15),
    BorderRadius inkWellBorderRadius,
    this.imageFit,
    this.height,
    this.width,
  })  : this.borderRadius = BorderRadius.circular(radius),
        this.imageBorderRadius = BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)),
        this.inkWellBorderRadius =
            inkWellBorderRadius ?? BorderRadius.circular(radius),
        assert(url != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _linkPreview();

  final String domain;
  final String url;
  final String title;
  final String description;
  final BorderRadius inkWellBorderRadius;
  final BorderRadius borderRadius;
  final BorderRadius imageBorderRadius;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Function() onTap;
  final double elevation;
  final TextStyle linkStyle;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final bool isLinkAtBottom;
  final EdgeInsets imagePadding;
  final EdgeInsets titlePadding;
  final EdgeInsets descriptionPadding;
  final EdgeInsets linkPadding;
  final EdgeInsets textPadding;
  final BoxFit imageFit;
  final double height;
  final double width;

  _stripUrl(String url) {
    url = url.replaceAll(RegExp(r'http[s ]://'), '');
    url = url.replaceAll(RegExp(r'/[^]*'), '');
    return url;
  }

  _horPad(Widget child) => Padding(child: child, padding: this.textPadding);

  _linkPreview() => Material(
      borderRadius: borderRadius,
      elevation: elevation,
      color: this.backgroundColor,
      child: InkWell(
          borderRadius: this.inkWellBorderRadius,
          onTap: this.onTap,
          child: Padding(
              padding: this.padding,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Image
                    Padding(
                        padding: imagePadding,
                        child: ClipRRect(
                            borderRadius: this.imageBorderRadius,
                            child: CachedNetworkImage(
                                height: height,
                                width: width,
                                fit: imageFit,
                                imageUrl: url,
                                progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ]),
                                errorWidget: (context, url, error) =>
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error, color: Colors.red),
                                    ])))),

                    /// Footer
                    isLinkAtBottom ? Container() : _linkText(),

                    /// Title
                    _title(),

                    /// Description
                    _desc(),

                    /// Link text
                    this.isLinkAtBottom ? _linkText() : Container(),
                  ]))));

  _title() => this.title == null
      ? Container()
      : _horPad(Padding(
          padding: titlePadding,
          child: Text(title,
              textScaleFactor: 1,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: this.titleStyle ??
                  TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black))));

  _desc() => this.description == null
      ? Container()
      : _horPad(Padding(
          padding: descriptionPadding,
          child: Text(description,
              textScaleFactor: 1,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: this.descriptionStyle ??
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.grey))));

  _linkText() => this.domain == null || this.domain == ''
      ? Container()
      : _horPad(Padding(
          padding: linkPadding,
          child: Text(_stripUrl(domain),
              textScaleFactor: 1,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: this.linkStyle ??
                  TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey))));
}
