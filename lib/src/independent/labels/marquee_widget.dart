import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final double height;
  final double width;
  final List<Widget>? items;

  /// Auto horizontal scroll of marquee widget.
  /// Any [items] listed will be automatically scrolled horizontally
  MarqueeWidget({
    this.width = 200,
    this.height = 24.0,
    this.items,
  });
  @override
  State<StatefulWidget> createState() => new _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget>
    with SingleTickerProviderStateMixin {
  ScrollController scrollCtrl = new ScrollController();
  AnimationController? animateCtrl;

  @override
  void dispose() {
    animateCtrl?.dispose();
    super.dispose();
  }

  @override
  initState() {
    double offset = 0.0;
    super.initState();
    animateCtrl =
        new AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..addListener(() {
            if (animateCtrl!.isCompleted) animateCtrl!.repeat();
            offset += 1.0;
            if (offset - 1 > scrollCtrl.offset) {
              offset = 0.0;
            }
            setState(() {
              scrollCtrl.jumpTo(offset);
            });
          });
    animateCtrl!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      color: Colors.transparent,
      height: widget.height,
      padding: EdgeInsets.all(4.0),
      child: Center(
        child: ListView(
          controller: scrollCtrl,
          children: widget.items!,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
