import 'package:flutter/material.dart';

/// Popup drop down menu.
class PopupDropMenu<T> {
  /// The current context.
  final BuildContext context;

  /// The Elevation of the menu.
  final double elevation;

  /// Background color of the menu.
  final Color backgroundColor;

  /// Shape of the menu.
  final ShapeBorder shape;

  /// Place this key to a content.
  /// For the popup to know where to show
  /// the drop down menu.
  final GlobalKey key = GlobalKey();

  /// Popup drop down menu.
  PopupDropMenu(
    this.context, {
    this.elevation,
    this.backgroundColor,
    this.shape,
  }) : assert(context != null, 'context must not be null.');

  Offset _getPosition() {
    try {
      final RenderBox obj = key.currentContext.findRenderObject();
      var offset = obj.localToGlobal(Offset.zero);
      return offset;
    } catch (err) {
      throw Exception('Could not get widget position.');
    }
  }

  /// Show the popup drop down menu.
  /// Offset the program.
  Future<T> show(List<PopupMenuItem<T>> items) async {
    Offset offset;
    try {
      offset = _getPosition();
    } catch (err) {
      throw Exception(err);
    }
    return await showMenu<T>(
        shape: this.shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: this.backgroundColor,
        elevation: this.elevation,
        context: context,
        items: items,
        position:
            RelativeRect.fromLTRB(offset.dx, offset.dy, offset.dx, offset.dy));
  }
}
