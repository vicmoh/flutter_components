import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum ClickableTextTypes { hyperlink, hashtag }

/// Smart text containing clickable hash tags
/// and hyper links.
class SmartText extends StatefulWidget {
  /// The text string.
  final String text;

  /// The default text style.
  final TextStyle style;

  /// The hash tag style.
  final TextStyle hashtagStyle;

  /// The hyper url link style.
  final TextStyle hyperlinkStyle;

  /// Callback function when a clickable text is
  /// on pressed.
  final Function(String, ClickableTextTypes) onPressed;

  /// Smart text containing clickable hash tags
  /// and hyper links.
  SmartText(
    this.text, {
    Key key,
    this.style = const TextStyle(color: Colors.black),
    this.hashtagStyle = const TextStyle(color: Colors.lightBlue),
    this.hyperlinkStyle = const TextStyle(
        color: Colors.lightBlue, decoration: TextDecoration.underline),
    @required this.onPressed,
  }) : super(key: key);

  @override
  _SmartTextState createState() => _SmartTextState();
}

class _SmartTextState extends State<SmartText> {
  static const _httpRegex =
      r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)";
  static const _urlRegex =
      r"[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)";
  static const _hashTagRegex = r"(?:\s|^)#[A-Za-z0-9\-\.\_]+(?:\s|$)";

  List<TapGestureRecognizer> _tapGestures = [];

  @override
  void initState() {
    super.initState();
    this.widget.text?.split(' ')?.forEach((word) {
      if (RegExp(_hashTagRegex).hasMatch(word))
        _tapGestures.add(TapGestureRecognizer());
      else if (RegExp(_urlRegex).hasMatch(word))
        _tapGestures.add(TapGestureRecognizer());
    });
  }

  @override
  void dispose() {
    _tapGestures?.forEach((gest) => gest?.dispose());
    super.dispose();
  }

  List<TextSpan> _texts(String text) {
    assert(text != null);
    List<TextSpan> textWidgets = [];
    int gestCount = 0;
    text.split(' ')?.forEach((word) {
      word += ' ';
      if (RegExp(_hashTagRegex).hasMatch(word))
        textWidgets.add(TextSpan(
            text: word,
            style: this.widget.hashtagStyle,
            recognizer: _tapGestures[gestCount++]
              ..onTap = () =>
                  this.widget.onPressed(word, ClickableTextTypes.hashtag)));
      else if (RegExp(_urlRegex).hasMatch(word))
        textWidgets.add(TextSpan(
            text: word,
            style: this.widget.hyperlinkStyle,
            recognizer: _tapGestures[gestCount++]
              ..onTap = () =>
                  this.widget.onPressed(word, ClickableTextTypes.hyperlink)));
      else
        textWidgets.add(TextSpan(text: word, style: this.widget.style));
    });
    return textWidgets;
  }

  @override
  Widget build(BuildContext context) => RichText(
      text: TextSpan(
          style: this.widget.style, children: _texts(this.widget.text)));
}
