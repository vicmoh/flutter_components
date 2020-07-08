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
  final FocusNode focusNode;
  final int maxLength;
  final String counterText;
  final Widget sendWidget;
  final Widget iconWidget;
  final CrossAxisAlignment sendCrossAxisAlignment;
  final Widget inputWidget;

  /// Class for sending and entering a message.
  /// Used in [ChatPage] and [LiveFeedPage]
  MessageField({
    Key key,
    @required this.onSend,
    this.onFieldChanged,
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.white,
    this.dividerColor = Colors.black,
    this.fieldController,
    this.innerVerticalPadding = 5,
    this.onSendLoadingWidget,
    this.isLoading = false,
    this.hintText = 'Enter a message...',
    this.hintTextFontScale = 1.2,
    this.focusNode,
    this.maxLength,
    this.counterText = "",
    this.sendWidget,
    this.inputWidget,
    this.sendCrossAxisAlignment = CrossAxisAlignment.end,
    this.iconWidget,
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
              Padding(
                  padding:
                      EdgeInsets.only(top: this.widget.innerVerticalPadding),
                  child: Row(
                      crossAxisAlignment: widget.sendCrossAxisAlignment,
                      children: <Widget>[
                        /// Text field for messaging
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: _textField())),

                        /// Send button
                        _sendButton(),
                      ])),

              /// Bottom padding for iPhone users
              Container(
                  padding:
                      EdgeInsets.only(bottom: widget.innerVerticalPadding)),
            ]));
  }

  _textField() =>
      widget.inputWidget ??
      TextField(
          maxLength: widget.maxLength,
          focusNode: widget.focusNode,
          controller: widget.fieldController,
          autocorrect: true,
          cursorColor: widget.textColor,
          maxLines: 5,
          minLines: 1,
          onChanged: widget.onFieldChanged ?? () {},
          style: TextStyle(
              color: widget.textColor,
              fontSize: 14 * this.widget.hintTextFontScale),
          decoration: InputDecoration(
              counterText: widget.counterText,
              border: InputBorder.none,
              hintText: this.widget.hintText,
              fillColor: widget.backgroundColor,
              hintStyle: TextStyle(
                  color: widget.textColor.withAlpha(200),
                  fontSize: 14 * this.widget.hintTextFontScale)));

  _sendButton() {
    Widget icon =
        widget.sendWidget ?? Icon(Icons.send, color: widget.textColor);
    if (this.widget.isLoading)
      icon = this.widget.onSendLoadingWidget ??
          CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              valueColor: AlwaysStoppedAnimation(Colors.white));
    return GestureDetector(
        onTap: widget.onSend,
        behavior: HitTestBehavior.opaque,
        child: this.widget.iconWidget ??
            Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: icon));
  }
}
