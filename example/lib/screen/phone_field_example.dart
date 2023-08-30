import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

class PhoneFieldExample extends StatefulWidget {
  PhoneFieldExample({super.key});

  @override
  _PhoneFieldExampleState createState() => _PhoneFieldExampleState();
}

class _PhoneFieldExampleState extends State<PhoneFieldExample> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Phone field example')),
        body: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: PhoneNumberField(
                isCountryCodeLoading: isLoading,
                onCountryCodeTap: () {
                  print('Country code is tapped.');
                  setState(() => isLoading = true);
                  Future.delayed(Duration(seconds: 3),
                      () => setState(() => isLoading = false));
                },
                onFieldChanged: (val) => print('Phone field value: $val'),
                borderRadius: BorderRadius.circular(10),
                countryCodeString: 'CD +1',
              )),
          Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: CustomField.round(maxLength: 128, onChanged: (val) {})),
        ]));
  }
}
