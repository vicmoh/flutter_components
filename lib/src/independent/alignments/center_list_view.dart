import 'package:flutter/material.dart';

/// A list view for showing content
/// center vertically. Takes a [child] widget
/// that will be shown in the middle of the list view.
class CenterListView extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? listViewPadding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  /// A list view for showing content
  /// center vertically. Takes a [child] widget
  /// that will be shown in the middle of the list view.
  const CenterListView({
    Key? key,
    this.listViewPadding,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.physics,
    this.controller,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: LayoutBuilder(builder: (context, constraint) {
      Widget child = Container(
          height: constraint.biggest.height,
          width: constraint.biggest.width,
          child: Column(
              mainAxisAlignment: this.mainAxisAlignment,
              crossAxisAlignment: this.crossAxisAlignment,
              children: <Widget>[this.child]));
      return ListView(
          controller: this.controller,
          padding: this.listViewPadding,
          physics: this.physics ??
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: <Widget>[child]);
    }));
  }
}
