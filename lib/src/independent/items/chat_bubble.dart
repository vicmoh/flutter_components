import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChatBubble<T> extends StatelessWidget {
  final String headerText;
  final String message;

  final EdgeInsetsGeometry avatarPadding;
  final String avatarUrl;
  final String avatarPlaceholderPath;
  final double avatarSize;

  final bool showSpacingWithHiddenAvatar;
  final bool isOnTheLeftSide;
  final bool displayNameInHeader;
  final bool showAvatar;

  final double bubbleMaxWidth;
  final BorderRadius borderRadius;
  final double headerTextScaleSize;
  final double messageTextScaleSize;

  final Color headerColor;
  final Color textColor;
  final Color backgroundColor;
  final LinearGradient backgroundGradient;

  final Widget headerWidget;
  final Widget bodyWidget;
  final Widget footerWidget;
  final Widget prefixWidget;

  final int maxMessageLines;
  final double bubbleElevation;
  final EdgeInsets padding;
  final EdgeInsets innerPadding;
  final FontWeight headerFontWeight;
  final FontWeight fontWeight;

  final CrossAxisAlignment avatarAlignment;
  final List<BoxShadow> bubbleShadows;

  final bool isReplyHeaderOutside;
  final Widget replyHeader;
  final Widget replyMessage;
  final BorderRadius replyBorderRadius;
  final Color replyBackgroundColor;
  final Function() onReplyTap;
  final List<dynamic> replies;
  final Widget Function(T) replyBuilder;
  final void Function() onTap;
  final void Function() onLongPress;

  /// Chat bubble mostly used for messaging.
  /// One of the parameter
  /// [message] or [bodyText] must exist.
  /// [message] where the chat bubble contains and wrap around.
  /// [isOnTheLeftSide] oh the list view, if its true bubble will be on the left side.
  /// [textColor] of the text on bubble.
  /// [backgroundColor] of the bubble.
  ChatBubble({
    this.bodyWidget,
    this.message,
    this.bubbleMaxWidth,
    this.showAvatar = true,
    this.headerTextScaleSize = 1,
    this.messageTextScaleSize = 1.2,
    this.headerText,
    this.avatarPadding = const EdgeInsets.only(),
    this.avatarPlaceholderPath,
    this.avatarUrl,
    this.isOnTheLeftSide = false,
    this.displayNameInHeader = true,
    this.textColor = Colors.white,
    Color backgroundColor,
    this.bubbleShadows,
    this.showSpacingWithHiddenAvatar = false,
    this.avatarAlignment = CrossAxisAlignment.start,
    BorderRadius borderRadius,
    this.avatarSize = 33,
    this.headerColor,
    this.headerWidget,
    this.maxMessageLines,
    this.headerFontWeight = FontWeight.normal,
    this.fontWeight,
    this.footerWidget,
    this.prefixWidget,
    this.padding = const EdgeInsets.symmetric(vertical: 3),
    this.innerPadding =
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    this.bubbleElevation = 0,

    /// For the reply section
    this.isReplyHeaderOutside = false,
    this.replyHeader,
    this.replyMessage,
    BorderRadius replyBorderRadius,
    this.replyBackgroundColor,
    this.onReplyTap,
    List<T> replies,
    this.replyBuilder,
    this.onTap,
    this.onLongPress,
    this.backgroundGradient,
  })  : assert(!(bodyWidget == null && message == null)),
        this.borderRadius = borderRadius ?? BorderRadius.circular(30),
        this.replyBorderRadius = replyBorderRadius ?? BorderRadius.circular(15),
        this.replies = replies ?? [],
        this.backgroundColor =
            backgroundColor ?? Color.fromRGBO(230, 230, 240, 1);

  double _maxWidth(BuildContext context) =>
      bubbleMaxWidth ?? MediaQuery.of(context).size.width * 0.7;

  /// Circle avatar for profile image
  Widget _avatar(BuildContext context) {
    /// Create the image avatar widget
    Widget image = Container();

    /// Edge case of the avatar widget
    if (!this.showAvatar) return image;
    if (this.avatarPlaceholderPath == null)
      image = Image.network(this.avatarUrl,
          width: this.avatarSize, height: this.avatarSize, fit: BoxFit.cover);
    if (this.avatarUrl == null)
      image = Image.asset(this.avatarPlaceholderPath,
          width: this.avatarSize, height: this.avatarSize, fit: BoxFit.cover);
    if (this.avatarUrl != null && this.avatarPlaceholderPath != null)
      image = FadeInImage.assetNetwork(
          image: this.avatarUrl,
          placeholder: this.avatarPlaceholderPath,
          width: this.avatarSize,
          height: this.avatarSize,
          fit: BoxFit.cover);

    /// Create the avatar widget
    return Opacity(
        opacity: (this.showSpacingWithHiddenAvatar) ? 0 : 1,
        child: Container(
            padding: EdgeInsets.only(right: 10),
            child: ClipOval(child: image)));
  }

  /// A single box chat tile
  Widget _chatBox(BuildContext context) => Container(
      padding: this.padding,
      child: Row(
          crossAxisAlignment: this.avatarAlignment,
          mainAxisAlignment: (isOnTheLeftSide == false)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            /// Avatar
            this.prefixWidget != null
                ? this.prefixWidget
                : this.avatarUrl == null
                    ? Container()
                    : Padding(
                        padding: this.avatarPadding, child: _avatar(context)),

            /// The message bubble
            Column(
                crossAxisAlignment: (isOnTheLeftSide == false)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  _singleReplyBox(context),
                  _bubbleContent(context),
                  _replyBox(context),
                ]),
          ]));

  static Widget defaultReplyHeader({
    String text = 'Replied',
    TextStyle style =
        const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    Color iconColor = Colors.white,
  }) =>
      Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5),
          child: RichText(
              text: TextSpan(children: [
            WidgetSpan(
                child: Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Transform.translate(
                        offset: Offset(0, -2),
                        child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Icon(Icons.reply,
                                color: iconColor, size: 15))))),
            TextSpan(text: text, style: style),
          ])));

  static Widget defaultReplyMessage(
    String text, {
    TextStyle style =
        const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    Color dividerColor = Colors.white,
  }) =>
      IntrinsicHeight(
          child: Row(mainAxisSize: MainAxisSize.min, children: [
        Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: VerticalDivider(color: dividerColor)),
        Flexible(
            child: Text(text,
                overflow: TextOverflow.ellipsis, maxLines: 3, style: style)),
      ]));

  _singleReplyBox(BuildContext context) => this.replyMessage == null
      ? Container()
      : Transform.translate(
          offset: Offset(0, 15),
          child: LimitedBox(
            maxWidth: _maxWidth(context),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              /// Show reply header outside.
              this.isReplyHeaderOutside
                  ? this.replyHeader ?? Container()
                  : Container(),

              /// The reply message box.
              Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Flexible(
                    child: Material(
                        borderRadius: this.replyBorderRadius,
                        color: this.replyBackgroundColor ??
                            Theme.of(context).primaryColor,
                        child: InkWell(
                            onTap: this.onReplyTap ?? () {},
                            borderRadius: this.replyBorderRadius,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 20, top: 10, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: this.replyBorderRadius),
                              child: this.isReplyHeaderOutside
                                  ? this.replyMessage
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          /// The reply text.
                                          this.replyHeader,

                                          /// The Divider and replying to
                                          this.replyMessage,
                                        ]),
                            )))),
              ]),
            ]),
          ));

  /// The reply box content
  Widget _replyBox(BuildContext context) {
    if (this.replies == null || this.replies.length == 0) return Container();

    /// Get the replies data
    List<Widget> list = [];
    int num = 0;
    for (var each in this.replies) {
      list.add(replyBuilder(each));
      num++;
      if (num >= 3) break;
    }

    /// Return the content
    return Container(
        padding: EdgeInsets.all(5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: list));
  }

  /// The message in the bubble and padding
  LimitedBox _bubbleContent(BuildContext context) {
    List<Widget> innerText = [];

    /// The name on top
    if (this.headerText != null && this.displayNameInHeader)
      innerText.add(Container(
          padding: EdgeInsets.only(bottom: 5),
          child: _smallText(this.headerText, color: this.headerColor)));

    /// Header widget
    if (this.headerWidget != null) innerText.add(this.headerWidget);

    /// The message
    innerText.add(this.bodyWidget ??
        Material(
            color: Colors.transparent,
            child: RichText(
                overflow: this.maxMessageLines == null
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                textScaleFactor: this.messageTextScaleSize,
                maxLines: this.maxMessageLines,
                text: TextSpan(
                    style: TextStyle(
                        fontWeight: this.headerFontWeight,
                        color:
                            this.headerColor ?? this.textColor.withAlpha(200)),
                    text: (this.headerText != null && !this.displayNameInHeader)
                        ? '$headerText: '
                        : '',
                    children: [
                      TextSpan(
                          text: '$message',
                          style: TextStyle(
                              fontWeight: this.fontWeight,
                              color: this.textColor)),
                    ]))));

    /// The footer of the bubble
    if (footerWidget != null) innerText.add(this.footerWidget);

    /// Create bubble
    return LimitedBox(
        maxWidth: _maxWidth(context),
        child: Material(
            color: this.backgroundColor,
            elevation: this.bubbleElevation,
            borderRadius: this.borderRadius,
            child: InkWell(
                borderRadius: this.borderRadius,
                onTap: this.onTap ?? () {},
                onLongPress: this.onLongPress ?? () {},
                child: Container(
                    padding: this.innerPadding,
                    // Message bubble color
                    decoration: BoxDecoration(
                        gradient: this.backgroundGradient,
                        borderRadius: this.borderRadius,
                        boxShadow: this.bubbleShadows),
                    // Inner text, the message
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: innerText)))));
  }

  /// The text in the bubble, used for display name.
  Widget _smallText(String text, {Color color}) => Material(
      color: Colors.transparent,
      child: Text(text,
          overflow: this.maxMessageLines == null
              ? TextOverflow.visible
              : TextOverflow.ellipsis,
          textScaleFactor: this.headerTextScaleSize,
          style: TextStyle(color: color ?? textColor.withAlpha(200))));

  /// Build the widget
  @override
  Widget build(BuildContext context) => _chatBox(context);
}
