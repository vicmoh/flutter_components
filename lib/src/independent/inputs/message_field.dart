import 'package:flutter/material.dart';

class MessageField extends StatefulWidget {
  final TextEditingController fieldController;
  final Color backgroundColor;
  final Color textColor;
  final Color dividerColor;
  final double innerVerticalPadding;
  final Function() onSend;
  final Function(String) onFieldChanged;

  /// Class for sending and entering a message.
  /// Used in [ChatPage] and [LiveFeedPage]
  MessageField({
    Key key,
    @required this.onFieldChanged,
    @required this.onSend,
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.white,
    this.dividerColor = Colors.black,
    this.fieldController,
    this.innerVerticalPadding = 5,
  }) : super(key: key);

  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  Widget build(BuildContext context) {
    return _messageField(context);
  }

  /// Message Field for entering a message and sending
  Widget _messageField(BuildContext context) {
    return Container(
        color: widget.backgroundColor,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Divider
              Container(height: 1, color: widget.dividerColor),
              // The Field and send button
              SizedBox(height: widget.innerVerticalPadding),
              Row(children: <Widget>[
                // Text field for messaging
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                            controller: widget.fieldController,
                            autocorrect: true,
                            cursorColor: widget.textColor,
                            maxLines: 5,
                            minLines: 1,
                            onChanged: widget.onFieldChanged,
                            style: TextStyle(
                                color: widget.textColor, fontSize: 14 * 1.2),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter a message...',
                                fillColor: widget.backgroundColor,
                                hintStyle: TextStyle(
                                    color: widget.textColor.withAlpha(200)))))),
                // Send button
                GestureDetector(
                    onTap: widget.onSend,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Icon(Icons.send, color: widget.textColor))),
              ]),
              // Bottom padding for iPhone users
              Container(
                  padding:
                      EdgeInsets.only(bottom: widget.innerVerticalPadding)),
            ]));
  }
}
