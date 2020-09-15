import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Clickable text types for the text that
/// are clickable. Used in [SmartText].
enum ClickableTextTypes { hyperlink, hashtag, atTag }

/// Smart text containing clickable hash tags
/// and hyper links.
class SmartText extends StatefulWidget {
  /// The text string.
  final String text;

  /// The default text style.
  final TextStyle style;

  /// The at symbol style.
  final TextStyle atTextStyle;

  /// The hash tag style.
  final TextStyle hashtagStyle;

  /// The hyper url link style.
  final TextStyle hyperlinkStyle;

  /// Text overflow type.
  final TextOverflow overflow;

  /// Number of lines the text will hold.
  final int maxLines;

  /// Text alignment.
  final TextAlign textAlign;

  /// Determine whether to show print debug.
  final bool showDebug;

  /// Callback function when a clickable text is
  /// on pressed.
  final Function(String, ClickableTextTypes) onPressed;

  /// Smart text containing clickable hash tags
  /// and hyper links.
  SmartText(
    this.text, {
    Key key,
    this.onPressed,
    this.maxLines,
    this.style = const TextStyle(color: Colors.black),
    this.hashtagStyle,
    this.hyperlinkStyle,
    this.atTextStyle,
    this.overflow = TextOverflow.clip,
    this.textAlign = TextAlign.left,
    this.showDebug = false,
  }) : super(key: key);

  static const HTTP_REGEX =
      r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)";

  static const HTTP_REGEX2 =
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})';

  /// Use HTTP_REGEX instead.
  @deprecated
  static const URL_REGEX =
      r"[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)";
  static const HASH_TAG_REGEX = r"(?:\s|^)#[A-Za-z0-9\-\.\_]+(?:\s|$)";
  static const AT_TAG_REGEX = r"(?:\s|^)@[A-Za-z0-9\-\.\_]+(?:\s|$)";

  @override
  _SmartTextState createState() => _SmartTextState();
}

class _SmartTextState extends State<SmartText> {
  List<TapGestureRecognizer> _tapGestures = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tapGestures?.forEach((gest) => gest?.dispose());
    super.dispose();
  }

  _showDebug(val) {
    if (widget.showDebug) print(val);
  }

  _addNormText(List<TextSpan> textWidgets, String word) {
    textWidgets.add(TextSpan(text: word, style: this.widget.style));
    textWidgets.add(TextSpan(text: ' ', style: this.widget.style));
  }

  _addText(List<TextSpan> textWidgets, String word) => 
    textWidgets.add(TextSpan(text: word, style: this.widget.style));

  _spaceText(textWidgets) =>
      textWidgets.add(TextSpan(text: ' ', style: this.widget.style));

  _addGesture(Function() onTap) {
    _tapGestures.add(TapGestureRecognizer());
    _tapGestures.last..onTap = onTap;
    return _tapGestures.last;
  }

  _isWhiteSpace(val) => (val == '\n' || val == '\r' || val == '\r\n');

  _addStyleText(List<TextSpan> textWidgets, String word) {
    /// For hashtag
    if (widget.hashtagStyle != null &&
        RegExp(SmartText.HASH_TAG_REGEX).hasMatch(word.trim())) {
      try {
        textWidgets.add(TextSpan(
            text: word,
            style: this.widget.hashtagStyle,
            recognizer: _addGesture(() {
              if (this.widget?.onPressed != null)
                this
                    .widget
                    .onPressed(word.trim(), ClickableTextTypes.hashtag);
            })));
        _spaceText(textWidgets);
      } catch (err) {
        _showDebug(err);
        _addNormText(textWidgets, word);
      }

      /// For hyper links
    } else if (widget.hyperlinkStyle != null &&
        RegExp(SmartText.HTTP_REGEX).hasMatch(word.trim())) {
      try {
        textWidgets.add(TextSpan(
            text: word,
            style: this.widget.hyperlinkStyle,
            recognizer: _addGesture(() {
              if (this.widget?.onPressed != null)
                this
                    .widget
                    .onPressed(word.trim(), ClickableTextTypes.hyperlink);
            })));
        _spaceText(textWidgets);
      } catch (err) {
        _showDebug(err);
        _addNormText(textWidgets, word);
      }

      /// For at symbol text
    } else if (widget.atTextStyle != null &&
        RegExp(SmartText.AT_TAG_REGEX).hasMatch(word.trim())) {
      try {
        textWidgets.add(TextSpan(
            text: word,
            style: this.widget.atTextStyle,
            recognizer: _addGesture(() {
              if (this.widget?.onPressed != null)
                this.widget.onPressed(word.trim(), ClickableTextTypes.atTag);
            })));
        _spaceText(textWidgets);
      } catch (err) {
        _showDebug(err);
        _addNormText(textWidgets, word);
      }

      /// Default text
    } else
      _addNormText(textWidgets, word);
  }

  List<TextSpan> _texts(String text) {
    assert(text != null);
    List<TextSpan> textWidgets = [];
    text?.split(' ')?.forEach((word) {
      word = word;
      _showDebug('word: $word');

      /// Check if there is white spaces.
      if (word.contains('\n') || word.contains('\t') || word.contains('\r\n')) {
        var cur = '';
        for (int x=0; x<word.length; x++) {

          /// To be added case
          if (x > 1 && !_isWhiteSpace(word[x - 1]) &&_isWhiteSpace(word[x])) {
            _addStyleText(textWidgets, cur);
            cur = '';
          }

          /// Determine whether it is white space or not.
          if (_isWhiteSpace(word[x])) {
            _addText(textWidgets, word[x]);
          } else {
            cur += word[x];
            if (word.length == 1) 
              _addStyleText(textWidgets, cur);
          }

          /// Last letter case
          if (x == word.length - 1) {
            _addStyleText(textWidgets, cur);
            cur = '';
          }
        }
      } else 
        _addStyleText(textWidgets, word);
    });
    textWidgets.removeLast();
    return textWidgets;
  }

  @override
  Widget build(BuildContext context) => RichText(
      textAlign: this.widget.textAlign,
      maxLines: this.widget.maxLines,
      overflow: this.widget.overflow,
      text: TextSpan(
          style: this.widget.style, children: _texts(this.widget.text)));
}
