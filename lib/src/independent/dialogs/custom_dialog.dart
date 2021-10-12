import 'dart:ui';

import 'package:flutter/material.dart';

enum _DialogType { simple, loader }

class CustomDialog extends StatefulWidget {
  final bool isCenterTitle;
  final bool isCenterBodyText;
  final String? title;
  final String? bodyText;
  final Widget? bodyChild;
  final Widget? footerChild;
  final MainAxisAlignment buttonHorizontalAlignment;
  final List<Widget>? buttons;
  final TextStyle titleStyle;
  final TextStyle bodyTextStyle;
  final Color backgroundColor;
  final double borderRadius;
  final double? width;
  final double? height;
  final bool isDoubleTapToCancel;
  final BoxConstraints? constraints;
  final _DialogType _type;

  static _defaultTitleStyle() => TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14 * 1.3);
  static _defaultBodyTextStyle() => TextStyle(
      color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14 * 1.1);

  /// Custom Dialog, must be wrap with [showDialog] function.
  CustomDialog({
    required this.title,
    required this.bodyText,
    this.isCenterTitle = false,
    this.isCenterBodyText = false,
    this.buttonHorizontalAlignment = MainAxisAlignment.end,
    this.backgroundColor = Colors.white,
    this.borderRadius = 10,
    this.height,
    this.width,
    this.footerChild,
    this.constraints,
    TextStyle? titleStyle,
    TextStyle? bodyTextStyle,
    this.buttons,
  })  : this._type = _DialogType.simple,
        this.isDoubleTapToCancel = false,
        this.bodyChild = null,
        this.titleStyle = titleStyle ?? _defaultTitleStyle(),
        this.bodyTextStyle = bodyTextStyle ?? _defaultBodyTextStyle();

  /// Custom Dialog, must be wrap with [showDialog] function.
  /// This uses [bodyChild] of a widget instead of [bodyText].
  CustomDialog.child({
    required this.bodyChild,
    this.footerChild,
    this.title,
    this.buttonHorizontalAlignment = MainAxisAlignment.end,
    this.backgroundColor = Colors.white,
    this.borderRadius = 10,
    this.height,
    this.width,
    this.constraints,
    this.buttons,
    TextStyle? titleStyle,
    TextStyle? bodyTextStyle,
  })  : this._type = _DialogType.simple,
        this.isCenterTitle = false,
        this.isCenterBodyText = false,
        this.isDoubleTapToCancel = false,
        this.bodyText = null,
        this.titleStyle = titleStyle ?? _defaultTitleStyle(),
        this.bodyTextStyle = bodyTextStyle ?? _defaultBodyTextStyle();

  /// A circular progress indicator used for loading.
  CustomDialog.loading({
    this.backgroundColor = Colors.white,
    this.isDoubleTapToCancel = true,
    this.constraints,
  })  : this._type = _DialogType.loader,
        this.title = '',
        this.buttonHorizontalAlignment = MainAxisAlignment.center,
        this.buttons = [],
        this.bodyChild = null,
        this.bodyText = null,
        this.height = 150,
        this.width = 100,
        this.borderRadius = 10,
        this.footerChild = null,
        this.isCenterTitle = true,
        this.isCenterBodyText = false,
        this.titleStyle = _defaultTitleStyle(),
        this.bodyTextStyle = _defaultBodyTextStyle();

  @override
  State<StatefulWidget> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  /// Build the widget
  @override
  Widget build(BuildContext context) {
    return (this.widget._type == _DialogType.simple)
        ? _normalWidget()
        : _loaderWidget();
  }

  //---------------------------------- Normal widget

  // Normal
  Widget _normalWidget() {
    return Dialog(
        // Shape of the dialog
        backgroundColor: widget.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius))),
        // Inner content
        child: Container(
            height: widget.height,
            width: widget.width,
            constraints: this.widget.constraints,
            child: _innerContent()));
  }

  // Inner content
  Container _innerContent() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // The title
              (widget.title == null)
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text(widget.title!,
                                textAlign: this.widget.isCenterTitle
                                    ? TextAlign.center
                                    : TextAlign.start,
                                style: widget.titleStyle)),
                      ])),

              // The body
              (widget.bodyText == null)
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text(widget.bodyText!,
                                textAlign: this.widget.isCenterBodyText
                                    ? TextAlign.center
                                    : TextAlign.start,
                                style: widget.bodyTextStyle)),
                      ])),

              /// Children
              (widget.bodyChild == null) ? Container() : widget.bodyChild!,

              // List of buttons
              (this.widget.footerChild != null)
                  ? widget.footerChild!
                  : (widget.buttons == null || widget.buttons!.length == 0)
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                              children: widget.buttons!,
                              mainAxisAlignment:
                                  this.widget.buttonHorizontalAlignment)),
            ]));
  }

  //---------------------------- Loader widget

  /// Widget loader
  Widget _loaderWidget() {
    return GestureDetector(
        onDoubleTap: () =>
            (widget.isDoubleTapToCancel) ? Navigator.pop(context) : () {},
        child: AbsorbPointer(
            child: Container(
                child: Dialog(
                    // Shape of the dialog
                    backgroundColor: widget.backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius))),

                    // Container
                    child: Container(
                        height: widget.height,
                        width: widget.width,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius)),

                        // The content with loader
                        child: Stack(children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // The loader
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator()
                                    ]),

                                // wait text
                                Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text('Please wait...',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ]),
                        ]))))));
  }
}
