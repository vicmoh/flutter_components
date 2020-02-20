import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final double nameTextScaleSize;
  final double messageTextScaleSize;
  final String avatarUrl;
  final String avatarPlaceholderPath;
  final Color backgroundColor;
  final Color textColor;
  final double bubbleMaxWidth;
  final double avatarSize;
  final bool showSpacingWithHiddenAvatar;
  final bool isOnTheLeftSide;
  final bool showNameOnTop;
  final double borderRadius;
  final bool showAvatar;
  final CrossAxisAlignment avatarAlignment;
  final List<BoxShadow> bubbleShadows;
  final List<dynamic> replies;
  final Widget Function(dynamic) replyBuilder;

  /// Chat bubble mostly used for messaging.
  /// [message] where the chat bubble contains and wrap around.
  /// [isOnTheLeftSide] oh the list view, if its true bubble will be on the left side.
  /// [textColor] of the text on bubble.
  /// [backgroundColor] of the bubble.
  ChatBubble({
    @required this.message,
    @required this.bubbleMaxWidth,
    this.showAvatar = true,
    this.nameTextScaleSize = 1,
    this.messageTextScaleSize = 1.2,
    this.name,
    this.time,
    this.avatarPlaceholderPath,
    this.avatarUrl,
    this.isOnTheLeftSide = false,
    this.showNameOnTop = true,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.bubbleShadows,
    this.showSpacingWithHiddenAvatar = false,
    this.avatarAlignment = CrossAxisAlignment.start,
    this.borderRadius = 10,
    this.avatarSize = 33,
    // For the reply section
    List<dynamic> replies,
    this.replyBuilder,
  }) : this.replies = replies ?? [];

  /// Circle avatar for profile image
  Widget _avatar(BuildContext context) {
    // Create the image avatar widget
    Widget image = Container();

    // Edge case of the avatar widget
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

    // Create the avatar widget
    return Opacity(
        opacity: (this.showSpacingWithHiddenAvatar) ? 0 : 1,
        child: Container(
            padding: EdgeInsets.only(right: 10),
            child: ClipOval(child: image)));
  }

  /// A single box chat tile
  Widget _chatBox(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
            crossAxisAlignment: this.avatarAlignment,
            mainAxisAlignment: (isOnTheLeftSide == false)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            // Content
            children: [
              // Avatar
              Container(child: _avatar(context)),
              // The message bubble
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _bubbleContent(context),
                    _replyBox(context),
                  ]),
            ]));
  }

  // The reply box content
  Widget _replyBox(BuildContext context) {
    if (this.replies == null || this.replies.length == 0) return Container();
    // Get the replies data
    List<Widget> list = [];
    int num = 0;
    for (var each in this.replies) {
      list.add(replyBuilder(each));
      num++;
      if (num >= 3) break;
    }

    // Return the content
    return Container(
        padding: EdgeInsets.all(5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: list));
  }

  /// The message in the bubble and padding
  LimitedBox _bubbleContent(BuildContext context) {
    List<Widget> innerText = [];
    // The name on top}
    if (this.name != null)
      innerText.add(Container(
          padding: EdgeInsets.only(bottom: 5),
          child: _smallText(
              this.name + (this.time != null ? ' - ${this.time}' : ''))));
    // The message
    innerText.add(RichText(
        overflow: TextOverflow.ellipsis,
        textScaleFactor: this.messageTextScaleSize,
        maxLines: 7,
        text: TextSpan(
            style: TextStyle(color: this.textColor.withAlpha(200)),
            text: (this.name == null || this.showNameOnTop) ? '' : '$name: ',
            children: [
              TextSpan(
                  text: '$message',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: this.textColor)),
            ])));

    // Create bubble
    return LimitedBox(
        maxWidth: bubbleMaxWidth,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // Message bubble color
            decoration: BoxDecoration(
                color: this.backgroundColor,
                borderRadius: BorderRadius.circular(this.borderRadius),
                boxShadow: this.bubbleShadows),
            // Inner text, the message
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: innerText)));
  }

  /// The text in the bubble
  Widget _smallText(String text) {
    return Text(text,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: this.nameTextScaleSize,
        textAlign: TextAlign.right,
        style: TextStyle(color: textColor.withAlpha(200)));
  }

  /// Build the widget
  @override
  Widget build(BuildContext context) {
    return _chatBox(context);
  }
}
