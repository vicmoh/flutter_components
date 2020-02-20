import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int maxLines;
  final Widget seeMoreButton;

  /// An expandable text where it limits the
  /// text unless you click [seeMoreButton] for example.
  /// If [seeMoreButton] is null, by default clickable
  /// text will be shown. By default the [maxLines] is 4
  /// before you see the see button
  ExpandableText({
    Key key,
    @required this.text,
    this.style,
    this.maxLines = 4,
    this.seeMoreButton,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Container(child: LayoutBuilder(builder: (context, constraints) {
      // Simulate the layout
      var painter = TextPainter(
          maxLines: this.widget.maxLines,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: TextSpan(text: this.widget.text, style: this.widget.style));

      // Trigger it to layout
      painter.layout(maxWidth: constraints.maxWidth);

      // Check which to render
      if (painter?.didExceedMaxLines != null && painter.didExceedMaxLines)
        return Container(
          child: Column(children: <Widget>[
            _text(maxLine: this.widget.maxLines),
            this.widget.seeMoreButton ??
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Text('See more',
                                style: TextStyle(color: Colors.grey))),
                      ]),
                ),
          ]),
        );
      else
        return _text();
    }));
  }

  Widget _text({int maxLine}) => Text(this.widget.text,
      style: this.widget.style,
      maxLines: maxLine ?? this.widget.maxLines,
      overflow: TextOverflow.ellipsis);
}
