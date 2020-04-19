import 'package:flutter/material.dart';
import '../../transitions/transparent_page_route.dart';

class FullScreenPopupView extends StatefulWidget {
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxConstraints constraints;
  final Curve animationCurve;
  final Duration animationDuration;
  final Color backgroundColor;
  final Widget Function(BuildContext context) builder;
  final bool disableSwipeToExit;

  /// A custom fullscreen popup view
  /// That can be dismiss by swiping horizontally.
  /// Should be used with [TransparentPageRoute].
  FullScreenPopupView({
    Key key,
    @required this.builder,
    this.animationCurve = Curves.elasticOut,
    Duration animationDuration,
    BorderRadius borderRadius,
    EdgeInsetsGeometry margin,
    EdgeInsetsGeometry padding,
    Color backgroundColor,
    BoxConstraints constraints,
    this.disableSwipeToExit = false,
  })  : this.borderRadius = borderRadius ?? BorderRadius.circular(30),
        this.margin = margin ?? EdgeInsets.all(20),
        this.padding = padding ?? EdgeInsets.all(20),
        this.backgroundColor = backgroundColor ?? Colors.white,
        this.constraints = constraints,
        this.animationDuration = animationDuration ?? Duration(seconds: 1),
        super(key: key);

  /// Show the fullscreen popup view by navigating to a new child in the tree..
  static Future<void> show(
    context, {
    @required Widget Function(BuildContext) builder,
    Curve animationCurve = Curves.elasticOut,
    Duration animationDuration,
    BorderRadius borderRadius,
    EdgeInsetsGeometry margin,
    EdgeInsetsGeometry padding,
    Color backgroundColor,
    BoxConstraints constraints,
    bool disableSwipeToExit = false,
  }) =>
      Navigator.push(
          context,
          TransparentPageRoute(
              builder: (_) => FullScreenPopupView(
                  builder: builder,
                  disableSwipeToExit: disableSwipeToExit,
                  animationCurve: animationCurve,
                  animationDuration: animationDuration,
                  borderRadius: borderRadius,
                  margin: margin,
                  padding: padding,
                  backgroundColor: backgroundColor,
                  constraints: constraints)));

  @override
  _FullScreenPopupViewState createState() => _FullScreenPopupViewState();
}

class _FullScreenPopupViewState extends State<FullScreenPopupView> {
  bool _isPopupShowed;
  bool _isPopping;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    // Set the logic so that it will show the popup from the side
    // and able to swipe left or right to dismiss.
    _isPopupShowed = false;
    _isPopping = false;
    _pageController = PageController(initialPage: 0)
      ..addListener(() {
        var curPage = _pageController.page.round();
        if (curPage == 1 || _isPopupShowed) {
          _isPopupShowed = true;
          if ((curPage > 1 || curPage < 1) && !_isPopping && _isPopupShowed) {
            _isPopping = true;
            Navigator.pop(context);
          }
        }
      });

    // Call the page controller to make after the tree is done loading.
    // So that the page controller is attached to the page view.
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _pageController?.animateToPage(1,
            duration: this.widget.animationDuration,
            curve: this.widget.animationCurve));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = this.widget.builder(context);
    return Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
            top: true,
            bottom: true,
            left: false,
            right: false,
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              physics: this.widget.disableSwipeToExit
                  ? NeverScrollableScrollPhysics(
                      parent: BouncingScrollPhysics())
                  : AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
              children: <Widget>[
                Container(),
                _card(child),
                Container(),
              ],
            )));
  }

  Container _card(Widget child) {
    return Container(
        constraints: this.widget.constraints,
        decoration: BoxDecoration(
            borderRadius: this.widget.borderRadius, color: Colors.white),
        margin: this.widget.margin,
        padding: this.widget.padding,
        child: child);
  }
}
