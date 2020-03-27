import 'package:flutter/material.dart';

class MessageField extends StatefulWidget {
  final TextEditingController fieldController;
  final Color backgroundColor;
  final Color textColor;
  final Color dividerColor;
  final double innerVerticalPadding;
  final Function() onSend;
  final Function(String) onFieldChanged;
  final Widget onSendLoadingWidget;
  final bool isLoading;
  final String hintText;
  final double hintTextFontScale;

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
    this.onSendLoadingWidget,
    this.isLoading,
    this.hintText = 'Enter a message...',
    this.hintTextFontScale = 1.2,
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
              /// Divider
              Container(height: 1, color: widget.dividerColor),

              /// The Field and send button
              SizedBox(height: widget.innerVerticalPadding),
              Row(children: <Widget>[
                /// Text field for messaging
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: _textField())),

                /// Send button
                _sendButton(),
              ]),

              /// Bottom padding for iPhone users
              Container(
                  padding:
                      EdgeInsets.only(bottom: widget.innerVerticalPadding)),
            ]));
  }

  TextField _textField() {
    return TextField(
        controller: widget.fieldController,
        autocorrect: true,
        cursorColor: widget.textColor,
        maxLines: 5,
        minLines: 1,
        onChanged: widget.onFieldChanged,
        style: TextStyle(
            color: widget.textColor,
            fontSize: 14 * this.widget.hintTextFontScale),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: this.widget.hintText,
            fillColor: widget.backgroundColor,
            hintStyle: TextStyle(
                color: widget.textColor.withAlpha(200),
                fontSize: 14 * this.widget.hintTextFontScale)));
  }

  _sendButton() {
    Widget icon = Icon(Icons.send, color: widget.textColor);
    if (this.widget.isLoading)
      icon = this.widget.onSendLoadingWidget ??
          CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              valueColor: AlwaysStoppedAnimation(Colors.white));
    return GestureDetector(
        onTap: widget.onSend,
        behavior: HitTestBehavior.opaque,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: icon));
  }
}
