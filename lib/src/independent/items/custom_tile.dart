import 'package:flutter/material.dart';

// Enum for the tile types
enum _TileType { withImage, message, ticket, icon, child }

class CustomTile extends StatelessWidget {
  final String? imageUrl;
  final String? imagePlaceholderPath;
  final List<String>? subImageUrls;
  // String for display
  final String heading;
  final String? subHeading;
  final String? time;
  final String? monthForDisplayDate;
  final String? dayForDisplayDate;
  // Padding and size
  final bool isHeadingUnderline;
  final bool isSubHeadingUnderline;
  final EdgeInsets? padding;
  final bool headIsBold;
  final bool subIsBold;
  final int headMaxLines;
  final int subMaxLines;
  final double headTextScale;
  final double subTextScale;
  final double? textWidth;
  final double? contentTopPadding;
  final double avatarSize;
  final EdgeInsetsGeometry? headAndSubHeadingPadding;
  // Color
  final Color headingColor;
  final Color subHeadingColor;
  final Color unreadIndicatorColor;
  final Color unreadBackgroundColor;
  final Color widgetBackgroundColor;
  // Boolean
  final bool showDivider;
  final bool isRead;
  // Icon and child
  final Icon? icon;
  final Widget? child;
  final Widget? trailing;
  // Callback and type
  final _TileType type;
  final Function onTap;
  final String? heroTag;

  /// A notification tile for the notification page list view.
  /// [imageUrl] a circle image, can be used with profile picture or event.
  CustomTile.withImage({
    required this.imageUrl,
    required this.heading,
    required this.onTap,
    this.time,
    this.contentTopPadding = 15,
    this.showDivider = true,
    this.subImageUrls,
    this.avatarSize = 50,
    this.isRead = true,
    this.subHeading,
    this.imagePlaceholderPath,
    this.headingColor = Colors.black,
    this.subHeadingColor = Colors.black,
    this.unreadBackgroundColor = Colors.transparent,
    this.unreadIndicatorColor = Colors.black,
    this.trailing,
    this.textWidth,
    this.subMaxLines = 3,
    this.subTextScale = 1,
    this.subIsBold = false,
    this.headIsBold = true,
    this.headTextScale = 1,
    this.headMaxLines = 1,
    this.isHeadingUnderline = false,
    this.isSubHeadingUnderline = false,
  })  : this.type = _TileType.withImage,
        this.widgetBackgroundColor = Colors.transparent,
        this.icon = null,
        this.child = null,
        this.headAndSubHeadingPadding = null,
        this.monthForDisplayDate = null,
        this.dayForDisplayDate = null,
        this.padding = null,
        this.heroTag = null;

  /// A notification tile for the notification page list view.
  /// [imageUrl] a circle image, can be used with profile picture or event.
  CustomTile.messageTile({
    required this.imageUrl,
    required this.heading,
    required this.time,
    required this.onTap,
    this.contentTopPadding = 15,
    this.showDivider = true,
    this.avatarSize = 40,
    this.isRead = true,
    this.subHeading,
    this.imagePlaceholderPath,
    this.headingColor = Colors.black,
    this.subHeadingColor = Colors.black,
    this.unreadBackgroundColor = Colors.transparent,
    this.unreadIndicatorColor = Colors.black,
    this.trailing,
    this.textWidth,
    this.subMaxLines = 1,
    this.subTextScale = 1.1,
    this.subIsBold = true,
    this.headIsBold = false,
    this.headTextScale = 0.8,
    this.headMaxLines = 1,
    this.isHeadingUnderline = false,
    this.isSubHeadingUnderline = false,
    this.child,
  })  : this.type = _TileType.message,
        this.widgetBackgroundColor = Colors.transparent,
        this.subImageUrls = null,
        this.icon = null,
        this.headAndSubHeadingPadding = null,
        this.monthForDisplayDate = null,
        this.dayForDisplayDate = null,
        this.padding = null,
        this.heroTag = null;

  /// A notification tile for the notification page list view.
  CustomTile.withIcon({
    required this.icon,
    required this.heading,
    required this.onTap,
    this.contentTopPadding = 0,
    this.showDivider = false,
    this.avatarSize = 40,
    this.isRead = true,
    this.subHeading,
    this.headingColor = Colors.black,
    this.subHeadingColor = Colors.black,
    this.unreadBackgroundColor = Colors.transparent,
    this.unreadIndicatorColor = Colors.black,
    this.trailing,
    this.textWidth,
    this.subMaxLines = 1,
    this.subTextScale = 1,
    this.subIsBold = false,
    this.headIsBold = true,
    this.headTextScale = 1,
    this.headMaxLines = 1,
    this.isHeadingUnderline = false,
    this.isSubHeadingUnderline = false,
  })  : this.type = _TileType.icon,
        this.widgetBackgroundColor = Colors.transparent,
        this.subImageUrls = null,
        this.imageUrl = null,
        this.time = null,
        this.child = null,
        this.imagePlaceholderPath = null,
        this.headAndSubHeadingPadding = null,
        this.monthForDisplayDate = null,
        this.dayForDisplayDate = null,
        this.padding = null,
        this.heroTag = null;

  /// A notification tile for the notification page list view.
  CustomTile.withChild({
    required this.child,
    required this.heading,
    required this.onTap,
    this.headAndSubHeadingPadding,
    this.widgetBackgroundColor = Colors.transparent,
    this.time,
    this.showDivider = false,
    this.avatarSize = 40,
    this.isRead = true,
    this.subHeading = '',
    this.headingColor = Colors.black,
    this.subHeadingColor = Colors.black,
    this.unreadBackgroundColor = Colors.transparent,
    this.unreadIndicatorColor = Colors.black,
    this.trailing,
    this.textWidth,
    this.subMaxLines = 1,
    this.subTextScale = 0.9,
    this.subIsBold = false,
    this.headIsBold = true,
    this.headTextScale = 1.1,
    this.headMaxLines = 1,
    this.padding,
    this.isHeadingUnderline = false,
    this.isSubHeadingUnderline = false,
  })  : this.type = _TileType.child,
        this.subImageUrls = null,
        this.icon = null,
        this.contentTopPadding = null,
        this.imageUrl = null,
        this.imagePlaceholderPath = null,
        this.monthForDisplayDate = null,
        this.dayForDisplayDate = null,
        this.heroTag = null;

  /// A notification tile for the notification page list view.
  /// [imageUrl] a circle image, can be used with profile picture or event.
  /// For parameter [time] for ticket, pass the time
  /// in format of string "<Month> <Date>".
  CustomTile.dateDisplay({
    required this.imageUrl,
    required this.heading,
    required this.time,
    required this.onTap,
    required this.widgetBackgroundColor,
    required this.monthForDisplayDate,
    required this.dayForDisplayDate,
    this.showDivider = false,
    this.avatarSize = 40,
    this.isRead = true,
    this.subHeading = '',
    this.imagePlaceholderPath,
    this.headingColor = Colors.black,
    this.subHeadingColor = Colors.black,
    this.unreadBackgroundColor = Colors.transparent,
    this.unreadIndicatorColor = Colors.black,
    this.trailing,
    this.textWidth,
    this.subMaxLines = 3,
    this.subTextScale = 1,
    this.subIsBold = false,
    this.headIsBold = true,
    this.headTextScale = 1,
    this.headMaxLines = 1,
    this.isHeadingUnderline = false,
    this.isSubHeadingUnderline = false,
    this.heroTag,
  })  : this.type = _TileType.ticket,
        this.subImageUrls = null,
        this.icon = null,
        this.contentTopPadding = null,
        this.child = null,
        this.headAndSubHeadingPadding = null,
        this.padding = null;

  //---------------------------------------------------------------------
  // Tile section for notification, message, and icon
  //---------------------------------------------------------------------

  /// Circle avatar for profile image
  Widget _avatar(BuildContext context) {
    Widget toBeReturn = Container();
    if (this.type == _TileType.icon) {
      toBeReturn = Container(
          child: this.icon,
          padding: EdgeInsets.only(
              left: 20,
              top: (subHeading != null) ? 0 : (this.contentTopPadding! + 4)));
    } else {
      toBeReturn = Container(
          child: ClipOval(
              child: (this.imagePlaceholderPath != null)
                  ? (this.imageUrl == null)
                      ? Image.asset(this.imagePlaceholderPath!,
                          width: this.avatarSize,
                          height: this.avatarSize,
                          fit: BoxFit.cover)
                      : FadeInImage.assetNetwork(
                          image: this.imageUrl!,
                          placeholder: this.imagePlaceholderPath!,
                          width: this.avatarSize,
                          height: this.avatarSize,
                          fit: BoxFit.cover)
                  : Image.network(this.imageUrl!,
                      width: this.avatarSize,
                      height: this.avatarSize,
                      fit: BoxFit.cover)));
    }
    return toBeReturn;
  }

  /// Sub images that show a row of images horizontally
  Widget _wrapImages(BuildContext context) {
    // Widget image function
    var image = (String url) => Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
                height: 40,
                width: 40,
                child: (this.imagePlaceholderPath == null)
                    ? Image.network(url, fit: BoxFit.cover)
                    : FadeInImage.assetNetwork(
                        image: url,
                        placeholder: this.imagePlaceholderPath!,
                        fit: BoxFit.cover))));

    // Create a list of images
    List<Widget> images = [];
    int count = 0;
    for (var each in this.subImageUrls!) {
      images.add(image(each));
      count++;
      if (count == 6) break;
    }

    // Return the wrap images
    return Container(child: Wrap(spacing: 7, runSpacing: 7, children: images));
  }

  /// Leading content
  Widget? _leading(BuildContext context) {
    if (this.child != null) return this.child;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[this._avatar(context)]);
  }

  /// Heading content
  Widget _heading(BuildContext context) {
    // Text widget
    var textWidget = (String? text) => Container(
        padding: EdgeInsets.only(top: this.contentTopPadding!),
        child: Container(
            width: this.textWidth,
            child: Text(text!,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                maxLines: this.headMaxLines,
                textScaleFactor: this.headTextScale,
                style: TextStyle(
                    decoration: (this.isHeadingUnderline)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    fontWeight:
                        (this.headIsBold) ? FontWeight.bold : FontWeight.normal,
                    color: this.headingColor))));

    // Return heading
    return Row(
      children: <Widget>[
        // Text heading
        Expanded(child: textWidget(this.heading)),

        // Show time if it is message
        (this.type != _TileType.message) ? Container() : textWidget(this.time),

        // Notification indicator
        (this.isRead)
            ? Container()
            : Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    color: this.unreadIndicatorColor, shape: BoxShape.circle)),
      ],
    );
  }

  /// Sub heading content
  Widget _subHeading(BuildContext context) {
    // Text widget
    var textWidget = (String? text) => Container(
        width: this.textWidth,
        child: Text(text!,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: this.subMaxLines,
            textScaleFactor: this.subTextScale,
            style: TextStyle(
                decoration: (this.isSubHeadingUnderline)
                    ? TextDecoration.underline
                    : TextDecoration.none,
                color: this.subHeadingColor,
                fontWeight:
                    (this.subIsBold) ? FontWeight.bold : FontWeight.normal)));

    // Spacing on top of the
    var topSpacing =
        () => SizedBox(height: (this.type == _TileType.message) ? 5 : 10);

    // Return the sub heading
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Detail information
        (this.subHeading == '' || this.subHeading == null)
            ? Container()
            : topSpacing(),
        (this.subHeading == '' || this.subHeading == null)
            ? Container()
            : textWidget(this.subHeading),

        // The wrap images if it need to show
        (this.subImageUrls == null) ? Container() : topSpacing(),
        (this.subImageUrls == null) ? Container() : this._wrapImages(context),

        // Time of the notification
        SizedBox(height: 10),
        (this.time == null || this.type == _TileType.message)
            ? Container()
            : textWidget(this.time),
        SizedBox(height: 10),
      ],
    );
  }

  /// Notification tile
  Widget _normalTileContent(BuildContext context) {
    return ListTile(
      // on tile click
      onTap: this.onTap as void Function()?,
      onLongPress: this.onTap as void Function()?,
      // Avatar
      leading: this._leading(context),
      // Head title
      title: this._heading(context),
      // Subtitle
      subtitle: this._subHeading(context),
      // Trailing
      trailing: this.trailing,
    );
  }

  //---------------------------------------------------------------------
  // Date display tile widget
  //---------------------------------------------------------------------

  /// Widget that show the month and date
  Widget _dateShowCaseWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Month
          Text(this.monthForDisplayDate ?? '',
              textScaleFactor: 0.8,
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          // Date
          Text(this.dayForDisplayDate ?? '',
              textScaleFactor: 1.5,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  /// A widget contain heading and sub heading in column
  Widget _headingAndSubHeading(BuildContext context) {
    return Container(
      width: this.textWidth,
      padding: EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Heading text
          Container(
              width: this.textWidth,
              child: Text(this.heading,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: this.headTextScale,
                  maxLines: this.headMaxLines,
                  style: TextStyle(
                      decoration: (this.isHeadingUnderline)
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      color: this.headingColor,
                      fontWeight: (this.headIsBold)
                          ? FontWeight.bold
                          : FontWeight.normal))),

          // Sub heading text
          SizedBox(height: 5),
          Container(
              width: this.textWidth,
              child: Text(this.subHeading!,
                  textScaleFactor: this.subTextScale,
                  style: TextStyle(
                      decoration: (this.isSubHeadingUnderline)
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      color: this.subHeadingColor,
                      fontWeight: (this.subIsBold)
                          ? FontWeight.bold
                          : FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                  maxLines: this.subMaxLines,
                  softWrap: true)),
        ],
      ),
    );
  }

  /// Image fo the event
  Widget _imageOfTheEvent(BuildContext context) {
    Widget image = ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Container(
            width: 100,
            height: 100,
            // Image
            child: (this.imagePlaceholderPath != null)
                ? FadeInImage.assetNetwork(
                    image: this.imageUrl ?? this.imagePlaceholderPath!,
                    placeholder: this.imagePlaceholderPath!,
                    fit: BoxFit.cover)
                : Image.network(this.imageUrl ?? this.imagePlaceholderPath!,
                    fit: BoxFit.cover)));

    return (this.heroTag != null)
        ? Hero(child: image, tag: this.heroTag!)
        : image;
  }

  /// The main ticket tile content
  Widget _dateDisplayContent(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        // The material widget
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: this.widgetBackgroundColor,
          child: Container(
            child: Row(children: <Widget>[
              // Date widget
              this._dateShowCaseWidget(context),
              // Heading and sub heading text
              Expanded(child: this._headingAndSubHeading(context)),
              // The image of the event
              this._imageOfTheEvent(context)
            ]),
          ),
        ),
      ),
    );
  }

  //---------------------------------------------------------------------
  // Custom child tile widget widget
  //---------------------------------------------------------------------

  /// Modal tile
  Widget _leadingChildTile(BuildContext context) {
    var content = Container(
        padding: this.padding,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Icon
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [this.child!]),
              // Sub and title
              Container(
                  padding: this.headAndSubHeadingPadding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Header text
                        Container(
                            width: this.textWidth,
                            child: Material(
                                color: Colors.transparent,
                                child: Text(this.heading,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: this.headMaxLines,
                                    textScaleFactor: this.headTextScale,
                                    style: TextStyle(
                                        decoration: (this.isHeadingUnderline)
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        color: this.headingColor,
                                        fontWeight: (this.headIsBold)
                                            ? FontWeight.bold
                                            : FontWeight.normal)))),

                        // Spacing
                        (this.subHeading == null || this.subHeading == '')
                            ? Container()
                            : SizedBox(height: 7),
                        // Sub text
                        (this.subHeading == null || this.subHeading == '')
                            ? Container()
                            : Container(
                                width: this.textWidth,
                                child: Material(
                                    color: Colors.transparent,
                                    child: Text(this.subHeading!,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: this.subMaxLines,
                                        style: TextStyle(
                                            decoration:
                                                (this.isSubHeadingUnderline)
                                                    ? TextDecoration.underline
                                                    : TextDecoration.none,
                                            color: this.subHeadingColor,
                                            fontWeight: (this.subIsBold)
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                        textScaleFactor: this.subTextScale))),
                      ])),
            ]));

    // Return the material
    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: this.onTap as void Function()?, child: content),
    );
  }

  /// Build the widget
  @override
  Widget build(BuildContext context) {
    // Back color
    var backgroundColor = this.unreadBackgroundColor;
    if (this.unreadBackgroundColor == Colors.transparent && !this.isRead)
      backgroundColor = Colors.black.withOpacity(0.3);

    // The content to be build
    Widget contentToBeBuild = Container();
    if (this.type == _TileType.ticket) {
      contentToBeBuild = this._dateDisplayContent(context);
    } else if (this.type == _TileType.child) {
      contentToBeBuild = this._leadingChildTile(context);
    } else {
      contentToBeBuild = Container(
          color: backgroundColor,
          child: Column(children: <Widget>[
            // Notifications tile
            this._normalTileContent(context),
            // Divider line
            (!this.showDivider)
                ? Container()
                : SizedBox(
                    height: 1,
                    child: Container(color: Colors.white.withOpacity(0.1))),
          ]));
    }

    // Build the widget
    return contentToBeBuild;
  }
}
