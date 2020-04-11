import 'package:flutter/material.dart';

enum _ButtonType { circle, dropDown, other }

class CustomButton extends StatelessWidget {
  // Label
  final double buttonLabelScaleSize;
  final String buttonLabel;
  final bool isBoldLabel;
  // With child
  final Widget child;
  // Color
  final Color outlineColor;
  final Color backgroundColor;
  final Color textColor;
  final LinearGradient backgroundGradient;
  // Padding and sizing
  final double verticalInnerPadding;
  final double horizontalInnerPadding;
  final double height;
  final double width;
  final double elevation;
  final BorderRadius borderRadius;
  // Other
  final double outlineWeight;
  final bool isCheckMarkShown;
  final bool isMaterial;
  final _ButtonType type;
  // Callback
  final void Function() onPressed;
  final void Function(dynamic) onChanged;

  /// Custom round button that being used through the app.
  /// [onPressed] is a call back function when the button is pressed.
  CustomButton.withText({
    @required this.onPressed,
    @required this.buttonLabel,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.isBoldLabel = false,
    this.verticalInnerPadding = 10,
    this.horizontalInnerPadding = 10,
    this.buttonLabelScaleSize = 1,
    this.elevation = 5,
    this.outlineColor,
    this.outlineWeight = 0,
    this.isCheckMarkShown = false,
    BorderRadius borderRadius,
    this.isMaterial = true,
    this.backgroundGradient,
  })  : this.type = _ButtonType.other,
        this.child = null,
        this.onChanged = null,
        this.width = null,
        this.height = null,
        this.borderRadius = borderRadius ?? BorderRadius.circular(30);

  /// Custom round button.
  /// [onPressed] is a call back function when the button is pressed.
  CustomButton.withChild({
    @required this.onPressed,
    @required this.child,
    this.backgroundColor = Colors.white,
    this.verticalInnerPadding = 10,
    this.horizontalInnerPadding = 10,
    this.elevation = 5,
    this.outlineColor,
    this.outlineWeight = 0,
    BorderRadius borderRadius,
    this.isMaterial = true,
    this.backgroundGradient,
  })  : this.type = _ButtonType.other,
        this.textColor = Colors.transparent,
        this.buttonLabelScaleSize = 1,
        this.buttonLabel = '',
        this.isCheckMarkShown = false,
        this.onChanged = null,
        this.width = null,
        this.height = null,
        this.borderRadius = borderRadius ?? BorderRadius.circular(30),
        this.isBoldLabel = false;

  /// Custom round drop down button.
  /// [onPressed] is a call back function when the button is pressed.
  CustomButton.dropDown({
    @required this.onChanged,
    @required this.buttonLabel,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.verticalInnerPadding = 0,
    this.horizontalInnerPadding = 10,
    this.elevation = 5,
    this.outlineColor,
    this.outlineWeight = 0,
    this.width,
    this.height,
    BorderRadius borderRadius,
    this.isMaterial = true,
  })  : assert(!(buttonLabel == null)),
        this.child = null,
        this.type = _ButtonType.dropDown,
        this.buttonLabelScaleSize = 0,
        this.isCheckMarkShown = false,
        this.onPressed = null,
        this.borderRadius = borderRadius ?? BorderRadius.circular(30),
        this.isBoldLabel = false,
        this.backgroundGradient = null;

  /// Custom round button.
  /// [onPressed] is a call back function when the button is pressed.
  /// [child] is recommended to be passed with [Icon] widget.
  CustomButton.circle({
    @required this.onPressed,
    @required this.child,
    this.outlineWeight = 0,
    this.outlineColor,
    this.backgroundColor = Colors.white,
    this.isMaterial = true,
    double size = 50,
  })  : this.width = size,
        this.verticalInnerPadding = null,
        this.horizontalInnerPadding = null,
        this.height = null,
        this.textColor = Colors.white,
        this.buttonLabel = '',
        this.isCheckMarkShown = false,
        this.borderRadius = null,
        this.buttonLabelScaleSize = 0,
        this.elevation = 5,
        this.onChanged = null,
        this.type = _ButtonType.circle,
        this.isBoldLabel = false,
        this.backgroundGradient = null;

  //----------------------------------------------------------------------------------
  // Functions to create the widgets are below
  //----------------------------------------------------------------------------------

  // Default text label
  Widget _textLabel(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: (this.isCheckMarkShown) ? 20 : 0),
        child: Text(this.buttonLabel,
            style: TextStyle(
                fontSize: 14 * this.buttonLabelScaleSize,
                color: this.textColor,
                fontWeight:
                    (this.isBoldLabel) ? FontWeight.bold : FontWeight.normal)));
  }

  /// Circle check mark that is only shown if set
  @deprecated
  Widget _circleCheckMarked(BuildContext context) {
    /// The outline
    return Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90), color: this.textColor),

        /// The content
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Color.fromRGBO(17, 23, 63, 1)),
            child: Icon(Icons.check, color: this.textColor)));
  }

  /// Round button
  Widget _normalButton(BuildContext context) {
    Widget button = Container(
        decoration: BoxDecoration(
            borderRadius: this.borderRadius, gradient: this.backgroundGradient),

        /// Button inner padding
        padding: EdgeInsets.symmetric(
            vertical: this.verticalInnerPadding,
            horizontal: this.horizontalInnerPadding),

        /// Inner text container
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: (this.child != null)
                ? this.child
                : Row(
                    mainAxisAlignment: (this.isCheckMarkShown)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: <Widget>[
                        // The inner text
                        (this.child == null)
                            ? this._textLabel(context)
                            : this.child,
                        // The check mark button
                        // TODO: _circleCheckedMarked is deprecated
                        (this.isCheckMarkShown)
                            ? this._circleCheckMarked(context)
                            : Container(),
                      ])));

    //? Return with outline
    return Container(

        /// Determine if it is material button
        child: (this.isMaterial)
            ? Material(
                elevation: this.elevation,
                color: this.backgroundColor,
                borderRadius: this.borderRadius,
                child: InkWell(
                    onTap: this.onPressed,
                    borderRadius: this.borderRadius,
                    child: button))
            : Container(
                child: GestureDetector(child: button, onTap: this.onPressed),
                decoration: BoxDecoration(
                    borderRadius: this.borderRadius,
                    color: this.backgroundColor)),

        /// Outline
        padding: EdgeInsets.all(this.outlineWeight),
        decoration: BoxDecoration(
            borderRadius: this.borderRadius, color: this.outlineColor));
  }

  // Drop down button
  Widget _dropDownButton(BuildContext context) {
    /// The menu item widget
    var itemWidget = (label) => DropdownMenuItem(value: 0, child: Text(label));

    /// List of items
    List<DropdownMenuItem> menuItems = [];
    menuItems.add(itemWidget(this.buttonLabel));

    /// Build items
    return Container(

        /// outline
        padding: EdgeInsets.all(this.outlineWeight),
        decoration: BoxDecoration(
            borderRadius: this.borderRadius, color: this.outlineColor),

        /// The button
        child: Container(
            width: this.width,
            height: this.height,

            /// Inner padding
            padding: EdgeInsets.symmetric(
                vertical: this.verticalInnerPadding,
                horizontal: this.horizontalInnerPadding),

            /// Radius and color
            decoration: BoxDecoration(
                borderRadius: this.borderRadius, color: this.backgroundColor),

            /// Drop down button
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                    elevation: 0,
                    isExpanded: true,
                    underline: Container(),
                    onChanged: this.onChanged,
                    hint: Container(
                        child: Text(this.buttonLabel,
                            style: TextStyle(color: this.textColor))),

                    /// Drop menu items
                    items: menuItems))));
  }

  /// Circle button
  Widget _circleButton(BuildContext context) => Container(

      /// Outline color and weight
      padding: EdgeInsets.all(this.outlineWeight),
      decoration:
          BoxDecoration(color: this.outlineColor, shape: BoxShape.circle),

      /// The button
      child: Container(
          width: this.width,
          height: this.width,
          child: new RawMaterialButton(
              fillColor: this.backgroundColor,
              onPressed: this.onPressed,
              shape: new CircleBorder(),
              elevation: this.elevation,
              child: this.child)));

  /// Build the widget
  @override
  Widget build(BuildContext context) {
    // Button type
    Widget button = Container();
    if (this.type == _ButtonType.circle)
      button = this._circleButton(context);
    else if (this.type == _ButtonType.dropDown)
      button = this._dropDownButton(context);
    else
      button = this._normalButton(context);
    // return the button
    return Container(width: this.width, child: button);
  }
}
