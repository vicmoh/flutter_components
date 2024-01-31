import 'package:flutter/material.dart';

enum _Type { round, outline, fourFieldsInRow }

class CustomField extends StatefulWidget {
  // scaling and ratio
  final TextInputAction textInputAction;
  final void Function(String value)? onSubmitted;
  final double? width;
  final double? height;
  final double textScaleFactor;
  final double borderRadiusValue;
  // colors
  final Color hintColor;
  final Color textColor;
  final Color cursorColor;
  final Color backgroundColor;
  // other
  final double elevation;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final void Function(String) onChanged;
  final String? hintText;
  final EdgeInsetsGeometry innerPadding;
  final FontWeight fontWeight;
  final bool autofocus;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final String counterText;
  final TextStyle? counterStyle;
  final FocusNode? focusNode;
  final InputBorder? border;
  final _Type type;
  // For outline
  final Color focusOutlineColor;
  final Color outlineColor;
  final double outlineWeight;
  // Suffix
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final bool expands;
  final bool? enabled;
  final Widget Function(bool isPassShown)? suffixForObscureText;

  final TextCapitalization textCapitalization;

  /// A round field widget. Usually used on top of a list view on
  /// home screen content. [onChanged] function call back when
  /// user type on the field.
  CustomField.round({
    required this.onChanged,
    this.textColor = Colors.white,
    this.cursorColor = Colors.white,
    this.hintColor = Colors.grey,
    this.backgroundColor = Colors.black12,
    this.keyboardType = TextInputType.text,
    this.innerPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    this.borderRadiusValue = 90,
    this.width,
    this.height,
    this.controller,
    this.textScaleFactor = 1.1,
    this.hintText = 'Enter...',
    this.autofocus = false,
    this.obscureText = false,
    this.suffix,
    this.prefixIcon,
    this.prefix,
    this.suffixForObscureText,
    this.maxLines = 1,
    this.minLines,
    this.maxLength = 128,
    this.fontWeight = FontWeight.w500,
    this.focusNode,
    this.border,
    this.expands = false,
    this.elevation = 0,
    this.enabled,
    this.counterText = '',
    this.counterStyle,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
  })  : this.type = _Type.round,
        // Outline
        this.outlineColor = Colors.transparent,
        this.focusOutlineColor = Colors.transparent,
        this.outlineWeight = 0;

  /// A field widget for that has outline surrounding. Usually
  /// used for form input. [onChanged] function call back when
  /// user type on the field.
  CustomField.outline({
    required this.onChanged,
    this.textColor = Colors.black,
    this.cursorColor = Colors.black,
    this.hintColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.keyboardType = TextInputType.text,
    this.innerPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    this.borderRadiusValue = 10,
    this.width,
    this.height,
    this.controller,
    this.textScaleFactor = 1.1,
    this.hintText = 'Enter...',
    this.autofocus = false,
    this.obscureText = false,
    // Exclusive outline parameter
    this.outlineColor = Colors.grey,
    this.focusOutlineColor = Colors.black,
    this.outlineWeight = 1,
    this.prefixIcon,
    this.prefix,
    this.suffix,
    this.suffixForObscureText,
    this.maxLines = 1,
    this.minLines,
    this.maxLength = 128,
    this.fontWeight = FontWeight.w500,
    this.focusNode,
    this.border,
    this.enabled,
    this.expands = false,
    this.counterText = '',
    this.counterStyle,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
  })  : this.type = _Type.outline,
        this.elevation = 0;

  /// A field widget that contains 4 fields in a row.
  /// Each field takes one character. Usually used
  /// for verification code. [onChanged] function call
  /// back when user type on the field.
  CustomField.fourFieldsInRow({
    required this.onChanged,
    this.textColor = Colors.black,
    this.cursorColor = Colors.black,
    this.hintColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.keyboardType = TextInputType.text,
    this.innerPadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 15,
    ),
    this.borderRadiusValue = 15,
    this.width = 50,
    this.height,
    this.controller,
    this.textScaleFactor = 3,
    this.autofocus = false,
    this.obscureText = false,
    // Exclusive outline parameter
    this.outlineColor = Colors.grey,
    this.focusOutlineColor = Colors.black,
    this.outlineWeight = 1,
    this.maxLines = 1,
    this.minLines = 1,
    this.fontWeight = FontWeight.w500,
    this.textCapitalization = TextCapitalization.none,
  })  : this.type = _Type.fourFieldsInRow,
        this.border = null,
        this.enabled = null,
        this.hintText = null,
        this.prefixIcon = null,
        this.prefix = null,
        this.suffix = null,
        this.suffixForObscureText = null,
        this.expands = false,
        this.focusNode = null,
        this.maxLength = null,
        this.elevation = 0,
        this.counterText = '',
        this.counterStyle = null,
        this.textInputAction = TextInputAction.none,
        this.onSubmitted = null;

  /// Build field
  @override
  State<StatefulWidget> createState() => _CustomField();
}

class _CustomField extends State<CustomField> {
  /// Variable to determine whether the password is
  /// shown or not.
  bool _isPasswordShown = false;

  /// Focus node for the four character. It is used so that
  /// that you can go to the next character field and focus.
  final List<FocusNode> _focusCharacter = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  /// List for holding the character values.
  var _characterControllers = <TextEditingController>[];

  /// Initialize state
  @override
  initState() {
    super.initState();
    for (int x = 0; x < 4; x++)
      _characterControllers.add(TextEditingController());
  }

  /// Dispose state
  @override
  dispose() {
    super.dispose();
    _characterControllers.forEach((el) => el.dispose());
    _focusCharacter.forEach((el) => el.dispose());
  }

  /// Build state
  @override
  Widget build(BuildContext context) {
    // Determine the type of widget
    Widget widgetToBeBuild = Container();
    if (widget.type == _Type.round)
      widgetToBeBuild = _roundField(context);
    else if (widget.type == _Type.outline)
      widgetToBeBuild = _outlineField(context);
    else if (widget.type == _Type.fourFieldsInRow) {
      widgetToBeBuild = _fourFieldsInRow(context);
    }

    // Return the widget;
    return widgetToBeBuild;
  }

  /// Function for determining how the suffix should be shown
  _suffixWidget() {
    // Gesture widget
    var gestureWidget = (widget.suffixForObscureText == null)
        ? null
        : GestureDetector(
            child: widget.suffixForObscureText!(_isPasswordShown),
            onTap: () => setState(
                () => _isPasswordShown = (_isPasswordShown) ? false : true));

    // Return the widget
    return (widget.obscureText == false) ? widget.suffix : gestureWidget;
  }

  /// Round text field context
  _roundField(BuildContext context) => Material(
      elevation: this.widget.elevation,
      color: this.widget.backgroundColor,
      borderRadius: BorderRadius.circular(this.widget.borderRadiusValue),
      child: Container(
          // Width and height
          width: this.widget.width,
          height: this.widget.height,

          // Text field
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                    textCapitalization: this.widget.textCapitalization,
                    textInputAction: this.widget.textInputAction,
                    onSubmitted: this.widget.onSubmitted ?? (_) {},
                    enabled: this.widget.enabled,
                    maxLength: this.widget.maxLength,
                    expands: this.widget.expands,
                    scrollPhysics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    focusNode: this.widget.focusNode,
                    obscureText: (this.widget.obscureText == false)
                        ? this.widget.obscureText
                        : !_isPasswordShown,
                    onChanged: this.widget.onChanged,
                    cursorColor: this.widget.cursorColor,
                    controller: this.widget.controller,
                    keyboardType: this.widget.keyboardType,
                    autofocus: this.widget.autofocus,
                    maxLines: this.widget.maxLines,
                    minLines: this.widget.minLines,
                    style: TextStyle(
                        color: this.widget.textColor,
                        fontSize: 14 * this.widget.textScaleFactor,
                        fontWeight: this.widget.fontWeight),

                    // Text decoration
                    decoration: InputDecoration(
                        counterText: this.widget.counterText,
                        counterStyle: this.widget.counterStyle,
                        contentPadding: this.widget.innerPadding,
                        hintText: this.widget.hintText,

                        // Prefix and suffix this.widget
                        prefixIcon: this.widget.prefixIcon,
                        prefix: this.widget.prefix,
                        suffix: _suffixWidget(),

                        // Hint style
                        hintStyle: TextStyle(
                            color: this.widget.hintColor,
                            fontWeight: this.widget.fontWeight),

                        // Outline input border
                        border: this.widget.border ??
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    this.widget.borderRadiusValue),
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0)))),
              ])));

  /// Round text field context
  _outlineField(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(

            /// Radius and Color
            width: this.widget.width,
            height: this.widget.height,

            /// Text field
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                    textCapitalization: this.widget.textCapitalization,
                    textInputAction: this.widget.textInputAction,
                    onSubmitted: this.widget.onSubmitted ?? (_) {},
                    enabled: this.widget.enabled,
                    maxLength: this.widget.maxLength,
                    expands: this.widget.expands,
                    scrollPhysics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    focusNode: this.widget.focusNode,
                    obscureText: (this.widget.obscureText == false)
                        ? this.widget.obscureText
                        : !_isPasswordShown,
                    onChanged: this.widget.onChanged,
                    cursorColor: this.widget.cursorColor,
                    controller: this.widget.controller,
                    keyboardType: this.widget.keyboardType,
                    autofocus: this.widget.autofocus,
                    maxLines: this.widget.maxLines,
                    minLines: this.widget.minLines,
                    style: TextStyle(
                        color: this.widget.textColor,
                        fontSize: 14 * this.widget.textScaleFactor),

                    /// Text decoration
                    decoration: InputDecoration(
                        counterText: this.widget.counterText,
                        counterStyle: this.widget.counterStyle,
                        labelText: this.widget.hintText,
                        labelStyle: TextStyle(
                            color: this.widget.hintColor,
                            fontWeight: this.widget.fontWeight),

                        /// Padding and color
                        contentPadding: this.widget.innerPadding,
                        filled: false,
                        fillColor: this.widget.backgroundColor,

                        /// Prefix and suffix this.widget
                        prefixIcon: this.widget.prefixIcon,
                        prefix: this.widget.prefix,
                        suffix: _suffixWidget(),

                        /// Outline border by default
                        enabledBorder: this.widget.border ??
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    this.widget.borderRadiusValue),
                                borderSide: BorderSide(
                                    width: this.widget.outlineWeight,
                                    color: this.widget.outlineColor)),

                        /// Outline border on focus
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                this.widget.borderRadiusValue),
                            borderSide: BorderSide(
                                width: this.widget.outlineWeight,
                                color: this.widget.focusOutlineColor)))),
              ],
            )));
  }

  /// Single field for digit input
  _singleFieldForFourDigit(
    BuildContext context, {
    required int currentFocusIndex,
    required int nextFocusIndex,
    required TextEditingController controller,
    bool isLastDigit = false,
  }) {
    return Container(
        // Radius and Color
        width: widget.width,
        height: widget.height,

        // Text field
        child: TextField(
            textCapitalization: widget.textCapitalization,
            scrollPhysics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            textInputAction:
                (isLastDigit) ? TextInputAction.done : TextInputAction.next,
            textAlign: TextAlign.center,
            obscureText: widget.obscureText,
            cursorColor: widget.cursorColor,
            keyboardType: widget.keyboardType,
            autofocus: widget.autofocus,
            controller: controller,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            focusNode: _focusCharacter[currentFocusIndex],
            onChanged: (val) {
              // Limit into a single character
              if (val.length > 1) controller.text = val.substring(1, 2);

              // Go to next field
              _focusCharacter[currentFocusIndex].unfocus();
              FocusScope.of(context)
                  .requestFocus(_focusCharacter[nextFocusIndex]);

              // Set the combined string from each field
              setState(() {
                String combined = '';
                for (var each in _characterControllers) combined += each.text;
                widget.onChanged(combined);
              });
            },
            style: TextStyle(
                color: widget.textColor, fontSize: 14 * widget.textScaleFactor),

            // Text decoration
            decoration: InputDecoration(
                labelText: widget.hintText,
                labelStyle: TextStyle(color: widget.hintColor),
                contentPadding: widget.innerPadding,
                filled: true,
                fillColor: widget.backgroundColor,

                // Outline border by default
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadiusValue),
                    borderSide: BorderSide(
                        width: widget.outlineWeight,
                        color: widget.outlineColor)),

                // Outline border on focus
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadiusValue),
                    borderSide: BorderSide(
                        width: widget.outlineWeight,
                        color: widget.focusOutlineColor)))));
  }

  /// Four digit input
  _fourFieldsInRow(BuildContext context) {
    List<Widget> rowDigits = [];
    for (int x = 0; x < _focusCharacter.length; x++) {
      rowDigits.add(Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: _singleFieldForFourDigit(context,
              controller: _characterControllers[x],
              currentFocusIndex: x,
              nextFocusIndex: (x + 1 >= _focusCharacter.length - 1)
                  ? _focusCharacter.length - 1
                  : x + 1)));
    }

    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center, children: rowDigits));
  }
}
