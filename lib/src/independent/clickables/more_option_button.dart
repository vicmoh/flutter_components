import 'package:flutter/material.dart';

class MoreOptionItem {
  final Function() onPressed;
  final Widget tile;
  MoreOptionItem({@required this.onPressed, @required this.tile})
      : assert(tile != null, 'tile cannot be null'),
        assert(onPressed != null, 'on pressed cannot be null');
}

class MoreOptionButton extends StatelessWidget {
  final RoundedRectangleBorder shape;
  final Widget child;
  final List<MoreOptionItem> items;

  /// A more option button that will popup
  /// a list of more options.
  const MoreOptionButton({
    Key key,
    @required this.child,
    @required this.items,
    this.shape,
  })  : assert(child != null, 'child cannot be null'),
        assert(items != null, 'items cannot be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem> tiles = [];
    for (var x = 0; x < this.items.length; x++)
      tiles.add(PopupMenuItem(child: this.items[x].tile, value: x));

    return PopupMenuButton(
        child: this.child,
        shape: this.shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onSelected: (val) => this.items[val].onPressed(),
        itemBuilder: (_) => tiles);
  }
}
