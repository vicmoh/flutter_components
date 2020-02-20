import 'dart:async';

import 'package:flutter/material.dart';

class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Axis scrollAxis;
  final double ratioOfBlankToScreen;

  /// A moving text label that moves horizontally
  /// to show all content of the string, 
  /// similar to music apps like Spotify
  /// where it shows the whole string in one line
  /// by moving the text horizontally to the left. 
  MarqueeText({
    @required this.text,
    this.textStyle,
    this.scrollAxis: Axis.horizontal,
    this.ratioOfBlankToScreen: 0.25,
  }) : assert(text != null);

  @override
  State<StatefulWidget> createState() {
    return new MarqueeTextState();
  }
}

class MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  double screenWidth;
  double screenHeight;
  double position = 0.0;
  Timer timer;
  final double _moveDistance = 3.0;
  final int _timerRest = 100;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      startTimer();
    });
  }

  void startTimer() {
    double widgetWidth =
        _key.currentContext.findRenderObject().paintBounds.size.width;
    double widgetHeight =
        _key.currentContext.findRenderObject().paintBounds.size.height;

    timer = Timer.periodic(new Duration(milliseconds: _timerRest), (timer) {
      double maxScrollExtent = scrollController.position.maxScrollExtent;
      double pixels = scrollController.position.pixels;
      if (pixels + _moveDistance >= maxScrollExtent) {
        if (widget.scrollAxis == Axis.horizontal) {
          position = (maxScrollExtent -
                      screenWidth * widget.ratioOfBlankToScreen +
                      widgetWidth) /
                  2 -
              widgetWidth +
              pixels -
              maxScrollExtent;
        } else {
          position = (maxScrollExtent -
                      screenHeight * widget.ratioOfBlankToScreen +
                      widgetHeight) /
                  2 -
              widgetHeight +
              pixels -
              maxScrollExtent;
        }
        scrollController.jumpTo(position);
      }
      position += _moveDistance;
      scrollController.animateTo(position,
          duration: new Duration(milliseconds: _timerRest),
          curve: Curves.linear);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  Widget getBothEndsChild() {
    if (widget.scrollAxis == Axis.vertical) {
      String newString = widget.text.split("").join("\n");
      return new Center(
        child: new Text(
          newString,
          style: widget.textStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
    return new Center(
        child: new Text(
      widget.text,
      style: widget.textStyle,
    ));
  }

  Widget getCenterChild() {
    if (widget.scrollAxis == Axis.horizontal) {
      return new Container(width: screenWidth * widget.ratioOfBlankToScreen);
    } else {
      return new Container(height: screenHeight * widget.ratioOfBlankToScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      key: _key,
      scrollDirection: widget.scrollAxis,
      controller: scrollController,
      physics: new NeverScrollableScrollPhysics(),
      children: <Widget>[
        getBothEndsChild(),
        getCenterChild(),
        getBothEndsChild(),
      ],
    );
  }
}
