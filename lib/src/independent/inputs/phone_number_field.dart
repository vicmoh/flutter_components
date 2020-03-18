import 'package:flutter/material.dart';

class PhoneNumberField extends StatefulWidget {
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final TextStyle textStyle;
  final String countryCodeString;
  final void Function() onCountryCodeTap;
  final void Function(String) onFieldChanged;
  final bool isCountryCodeLoading;

  /// A simple phone number input field containing the country code
  /// button and the field choice. [onFieldChanged] callbacks a string
  /// including the country code when on field is changed.
  PhoneNumberField(
      {Key key,
      @required this.onCountryCodeTap,
      @required this.onFieldChanged,
      BorderRadius borderRadius,
      Color backgroundColor,
      TextStyle textStyle,
      this.isCountryCodeLoading = false,
      this.countryCodeString = 'CD +1'})
      : this.borderRadius = borderRadius ?? BorderRadius.circular(10),
        this.backgroundColor = backgroundColor ?? Colors.black12,
        this.textStyle = TextStyle(fontSize: 14 * 1.4, color: Colors.black),
        super(key: key);

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: _countryCodeDropDownBtn()),
        Expanded(child: _phoneNumField()),
      ]),
    ]);
  }

  Material _phoneNumField() => Material(
      borderRadius: this.widget.borderRadius,
      color: this.widget.backgroundColor,
      child: TextField(
          onChanged: (phone) => this
              .widget
              .onFieldChanged('${this.widget.countryCodeString} $phone'),
          keyboardType: TextInputType.phone,
          style: this.widget.textStyle,
          maxLines: 1,
          decoration: InputDecoration(
              hintText: 'Phone number',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15))));

  Material _countryCodeDropDownBtn() => Material(
      color: this.widget.backgroundColor,
      borderRadius: this.widget.borderRadius,
      child: this.widget.isCountryCodeLoading
          ? CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor)
          : InkWell(
              focusColor: Theme.of(context).primaryColor,
              onTap: this.widget.onCountryCodeTap,
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(children: <Widget>[
                    Text(this.widget.countryCodeString,
                        style: this.widget.textStyle),
                    Container(child: Icon(Icons.arrow_drop_down)),
                  ]))));
}
