import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

/// An expandable text where it limits the
/// text unless you click [seeMoreButton] for example.
/// If [seeMoreButton] is null, by default clickable
/// text will be shown. By default the [maxLines] is 5
/// before you see the see button.
class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int maxLines;
  final Widget seeMoreButton;
  final Function() seeMorePressed;
  final TextAlign textAlign;
  final TextStyle hashtagStyle;
  final TextStyle hyperlinkStyle;
  final TextOverflow overflow;
  final Function(String, ClickableTextTypes) onClickableText;

  /// An expandable text where it limits the
  /// text unless you click [seeMoreButton] for example.
  /// If [seeMoreButton] is null, by default clickable
  /// text will be shown. By default the [maxLines] is 5
  /// before you see the see button.
  ExpandableText(
    this.text, {
    Key key,
    this.style,
    this.maxLines = 5,
    this.seeMoreButton,
    this.seeMorePressed,
    this.onClickableText,
    this.hashtagStyle = const TextStyle(color: Colors.lightBlue),
    this.hyperlinkStyle = const TextStyle(
        color: Colors.lightBlue, decoration: TextDecoration.underline),
    this.overflow = TextOverflow.clip,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Container(child: LayoutBuilder(builder: (context, constraints) {
      /// Simulate the layout
      var painter = TextPainter(
          maxLines: this.widget.maxLines,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: TextSpan(text: this.widget.text, style: this.widget.style));

      /// Trigger it to layout
      painter.layout(maxWidth: constraints.maxWidth);

      /// Check which to render
      if (painter?.didExceedMaxLines != null && painter.didExceedMaxLines)
        return Container(
          child: Column(children: <Widget>[
            _text(),
            this.widget.seeMoreButton ??
                Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: GestureDetector(
                                  onTap: this.widget.seeMorePressed ?? () {},
                                  child: Text('See more',
                                      style: TextStyle(color: Colors.grey)))),
                        ])),
          ]),
        );
      else
        return _text();
    }));
  }

  _text() => SmartText(this.widget.text,
      hashtagStyle: this.widget.hashtagStyle,
      hyperlinkStyle: this.widget.hyperlinkStyle,
      onPressed: this.widget.onClickableText,
      textAlign: this.widget.textAlign,
      style: this.widget.style,
      maxLines: this.widget.maxLines,
      overflow: TextOverflow.ellipsis);
}
