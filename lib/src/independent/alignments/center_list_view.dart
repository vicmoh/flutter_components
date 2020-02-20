import 'package:flutter/material.dart';

class CenterListView extends StatelessWidget {
  final bool isCenter;
  final Widget child;
  final EdgeInsetsGeometry listViewPadding;

  /// A [ListView] for showing content
  /// center vertically. Takes a [child] [Widget]
  /// that will be shown in the middle of the list view.
  /// If you want to have more content, you can pass [Column]
  /// on the [child].
  const CenterListView({
    Key key,
    this.isCenter = true,
    this.listViewPadding,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: LayoutBuilder(builder: (context, constraint) {
      Widget child = this.child;
      if (this.isCenter)
        child = Container(
            height: constraint.biggest.height,
            width: constraint.biggest.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[this.child]));
      return ListView(
          padding: this.listViewPadding,
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: <Widget>[child]);
    }));
  }
}
