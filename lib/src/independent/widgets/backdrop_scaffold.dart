import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Builds a Backdrop.
///
/// A Backdrop widget has two panels, front and back. The front panel is shown
/// by default, and slides down to show the back panel, from which a user
/// can make a selection. The user can also configure the titles for when the
/// front or back panel is showing.
class BackdropScaffold extends StatefulWidget {
  /// Function builder to build the content of inner modal.
  /// Function([AnimationController panelController], [double backdropHeight],
  /// [Function toggleBackdropPanelVisibility],
  /// [bool isBackdropPanelVisible]) -> Widget
  final Widget Function(
    AnimationController panelController,
    double backdropHeight,
    Function toggleBackdropPanelVisibility,
    bool isBackdropPanelVisible,
  ) frontPanelBuilder;
  final void Function(Function update, Function end) getVerticalDrags;
  final double maxFrontPanelHeight;
  final Widget frontPanel;
  final Widget backPanel;
  final Widget handleBarContent;
  final Color backdropColor;
  final Color handleBarColor;
  final Color backgroundColor;
  final PreferredSizeWidget appBar;
  final double handleBarSpacing;
  final double constVelocity;
  final bool isFrostedGlassBackground;
  final bool isFadeAnimated;
  final BorderRadius borderRadius;
  final bool openByDefault;

  /// Backdrop is a modal that can be drag up and down
  /// that sits on top of the page.
  const BackdropScaffold({
    @required this.backPanel,
    @required this.handleBarContent,
    BorderRadius borderRadius,
    this.maxFrontPanelHeight = 110,
    this.handleBarColor = Colors.grey,
    this.backdropColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.handleBarSpacing = 50,
    this.appBar,
    this.isFadeAnimated = false,
    this.isFrostedGlassBackground = false,
    this.frontPanelBuilder,
    this.frontPanel,
    this.constVelocity = 1,
    this.getVerticalDrags,
    this.openByDefault = false,
  })  : assert(handleBarContent != null),
        assert(frontPanel != null || frontPanelBuilder != null),
        assert(backPanel != null),
        this.borderRadius = borderRadius ??
            const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0));

  @override
  _BackdropScaffoldState createState() => _BackdropScaffoldState();
}

class _BackdropScaffoldState extends State<BackdropScaffold>
    with TickerProviderStateMixin {
  /// Back drop key to get the back drop height.
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  /// Declare animation controller for controlling the animation.
  AnimationController _panelController;

  /// Animation controller for fade in.
  AnimationController _fadeController;

  /// The animation for the fade.
  Animation<double> _fadeAnimation;

  /// Initialize the state.
  @override
  void initState() {
    super.initState();
    // This creates an [AnimationController] that can allows for animation for
    // the BackdropPanel. 0.00 means that the front panel is in "tab" (hidden)
    // mode, while 1.0 means that the front panel is open.
    this._panelController = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 0.0,
      vsync: this,
    );

    // set the init state of the modal.
    // When the value is set to zero the modal starts
    // At the bottom of the code.
    this._panelController.value = 0;

    // Set the animation for the fade panel
    this._fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    this._fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    this._fadeController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) => _openByDefault());
  }

  /// When state is completed.
  @override
  void dispose() {
    this._panelController?.dispose();
    this._fadeController?.dispose();
    super.dispose();
  }

  void _openByDefault() {
    Future.delayed(Duration(milliseconds: 500)).then((done) {
      if (widget.openByDefault) _toggleBackdropPanelVisibility();
    });
  }

  /// Check weather the back drop panel is visible.
  bool get _isBackdropPanelVisible {
    final AnimationStatus status = _panelController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  /// Get the backdrop panel height from the
  /// global back drop key that it is using.
  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext?.findRenderObject();
    return renderBox?.size?.height;
  }

  /// The backdrop panel visibility
  void _toggleBackdropPanelVisibility() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_panelController.isAnimating)
      _panelController.fling(
          velocity: _isBackdropPanelVisible
              ? -widget.constVelocity
              : widget.constVelocity);
  }

  /// The handle drag when user is currently dragging.
  void _handleDragUpdate(DragUpdateDetails details) {
    _panelController.value -= details.primaryDelta / _backdropHeight;
  }

  /// The handler drag for vertical at the end of swipe.
  void _handleDragEnd(DragEndDetails details) {
    // Case check
    if (_panelController.isAnimating ||
        _panelController.status == AnimationStatus.completed ||
        _panelController.status == AnimationStatus.dismissed) return;
    // Fling velocity
    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;
    // Condition of the handle fling.
    if (flingVelocity < 0.0) {
      // When swiping up
      _panelController.fling(
          velocity: math.max(widget.constVelocity, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      // When swiping down
      _panelController.fling(
          velocity: math.min(-widget.constVelocity, -flingVelocity));
    } else {
      // On tap
      _panelController.fling(
          velocity: _panelController.value < 0.5
              ? -widget.constVelocity
              : widget.constVelocity);
    }
  }

  /// Build stack where the modal will be placed on top of content.
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final double panelTitleHeight = widget.handleBarSpacing;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;
    final double panelBottom = panelTop - panelSize.height - 999;

    // Panel animation.
    Animation<RelativeRect> panelAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, panelTop, 0.0, panelBottom),
      end: RelativeRect.fromLTRB(0.0, widget.maxFrontPanelHeight, 0.0, 0.0),
    ).animate(this._panelController.view);

    // Call back for the drag handler
    if (widget?.getVerticalDrags != null)
      widget.getVerticalDrags(_handleDragUpdate, _handleDragEnd);

    // Determine if what widget to use
    var toBeChild = widget.frontPanel ??
        widget.frontPanelBuilder(
          this._panelController,
          this._backdropHeight,
          this._toggleBackdropPanelVisibility,
          this._isBackdropPanelVisible,
        );

    var backdropPanel = _BackdropPanel(
        isFrostedGlassBackground: widget.isFrostedGlassBackground,
        borderRadius: widget.borderRadius,
        onTap: this._toggleBackdropPanelVisibility,
        onVerticalDragUpdate: this._handleDragUpdate,
        onVerticalDragEnd: this._handleDragEnd,
        handleBarContent: widget.handleBarContent,
        backgroundColor: widget.backdropColor,
        handleBarColor: widget.handleBarColor,
        // The front panel
        child: toBeChild);

    // Return the stack with the back drop panel
    return Container(
        key: _backdropKey,
        color: widget.backgroundColor,
        child: Stack(children: <Widget>[
          // The back panel
          widget.backPanel,
          // The back drop panel
          PositionedTransition(
              rect: panelAnimation,
              child: (widget.isFadeAnimated)
                  ? FadeTransition(
                      opacity: this._fadeAnimation, child: backdropPanel)
                  : backdropPanel),
        ]));
  }

  /// Build the backdrop widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: widget.appBar,
        body: LayoutBuilder(builder: _buildStack),
        resizeToAvoidBottomPadding: false);
  }
}

/*
 * NOTE: The content belows are widgets that will be used
 * on the backdrop. The class contains panel and other
 * stateless widget.
 */

class _BackdropPanel extends StatefulWidget {
  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget handleBarContent;
  final Widget child;
  final Color backgroundColor;
  final Color handleBarColor;
  final BorderRadius borderRadius;
  final Key handleBarKey;
  final bool isFrostedGlassBackground;

  /// The back drop panel.
  const _BackdropPanel({
    Key key,
    @required this.onTap,
    @required this.child,
    BorderRadius borderRadius,
    this.isFrostedGlassBackground = false,
    this.handleBarKey,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.handleBarContent,
    this.backgroundColor = Colors.white,
    this.handleBarColor = Colors.grey,
  })  : this.borderRadius = borderRadius ??
            const BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
        super(key: key);

  /// Create the state
  @override
  State<StatefulWidget> createState() => _BackdropPanelState();
}

class _BackdropPanelState extends State<_BackdropPanel> {
  /// Init state of the backdrop
  @override
  initState() {
    super.initState();
  }

  /// Dispose
  @override
  dispose() {
    super.dispose();
  }

  /// The handler bar at top
  Widget _handlerBar() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          width: 50,
          height: 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: widget.handleBarColor)),
    ]);
  }

  /// Build the panel.
  @override
  Widget build(BuildContext context) {
    // The default starting widget
    Widget toBeReturn = Material(
        color: widget.backgroundColor,
        elevation: 5.0,
        borderRadius: widget.borderRadius,
        child: Column(children: <Widget>[
          // The handle bar and its content
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: widget.onVerticalDragUpdate,
              onVerticalDragEnd: widget.onVerticalDragEnd,
              onTap: widget.onTap,
              child: Container(
                  padding: EdgeInsets.only(top: 15),
                  key: widget.handleBarKey,
                  alignment: AlignmentDirectional.centerStart,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        this._handlerBar(),
                        widget.handleBarContent,
                      ]))),
          // The content below the handle bar
          Expanded(child: widget.child),
        ]));

    // Set frosted glass background is condition is true
    if (widget.isFrostedGlassBackground)
      toBeReturn = ClipRRect(
          borderRadius: widget.borderRadius,
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: toBeReturn));

    // Return the widget
    return toBeReturn;
  }
}
