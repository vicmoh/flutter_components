import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  // The string content
  final String name;
  final String message;
  final String bottomRightHead;
  final String bottomRightSub;
  final String numberOfLikes;
  final String numberOfDislikes;
  final String numberOfComments;
  final bool isOriginalPost;
  // The color
  final Color nameColor;
  final Color messageColor;
  final Color bottomRightTextColor;
  final Color thumbsUpColor;
  final Color thumbsDownColor;
  // Callback
  final Function()? onLiked;
  final Function()? onDisliked;

  const CommentTile({
    Key? key,
    required this.name,
    required this.message,
    this.bottomRightHead = '',
    this.bottomRightSub = '',
    this.numberOfLikes = '',
    this.numberOfDislikes = '',
    this.numberOfComments = '',
    this.isOriginalPost = false,
    // Color
    this.nameColor = Colors.grey,
    this.messageColor = Colors.black87,
    this.bottomRightTextColor = Colors.grey,
    this.thumbsUpColor = Colors.grey,
    this.thumbsDownColor = Colors.grey,
    this.onLiked,
    this.onDisliked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Rich text that contains name and message
          _richText(),
          // The options and information
          SizedBox(height: 3),
          _optionSection(),
        ],
      ),
    );
  }

  /// The options section that contains the thumb icons
  /// and the time and location information.
  Row _optionSection() {
    return Row(
      children: <Widget>[
        // The thumbs up
        GestureDetector(
            onTap: this.onLiked,
            child: Row(children: <Widget>[
              Icon(Icons.thumb_up, color: this.thumbsUpColor),
              SizedBox(width: 5),
              Text(this.numberOfLikes,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ])),
        // The thumbs down
        SizedBox(width: 15),
        GestureDetector(
            onTap: this.onDisliked,
            child: Row(children: <Widget>[
              Icon(Icons.thumb_down, color: this.thumbsDownColor),
              SizedBox(width: 5),
              Text(this.numberOfDislikes,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ])),
        // The information such as time and location
        SizedBox(width: 5),
        Expanded(child: _postInfoTexts())
      ],
    );
  }

  /// The post information texts such as time posted and location
  Column _postInfoTexts() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // The time
          Text(this.bottomRightHead,
              // textScaleFactor: 0.8,
              textScaler: TextScaler.linear(0.8),
              style: TextStyle(color: this.bottomRightTextColor)),
          // The location
          Text(this.bottomRightSub,
              // textScaleFactor: 0.8,
              textScaler: TextScaler.linear(0.8),
              style: TextStyle(color: this.bottomRightTextColor)),
        ]);
  }

  /// The rich text containing the message and name
  RichText _richText() {
    return RichText(
      text: TextSpan(
        children: [
          // Name
          TextSpan(
              text: this.name,
              style: TextStyle(
                  fontSize: 14 * 1.1,
                  color: this.nameColor,
                  fontWeight: FontWeight.bold)),
          // Original post tag
          TextSpan(
              text: ' OP'.toUpperCase(),
              style: TextStyle(
                  fontSize: 14 * 1.1,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold)),
          // Message
          TextSpan(
              text: ' ${this.message}',
              style: TextStyle(fontSize: 14 * 1.1, color: this.messageColor)),
        ],
      ),
    );
  }
}
