import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

class InputFieldExample extends StatefulWidget {
  createState() => _InputFieldExampleState();
}

class _InputFieldExampleState extends State<InputFieldExample> {
  build(ctx) => Scaffold(
      appBar: AppBar(),
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          children: [
            CustomField.round(
                maxLines: 1,
                width: 100,
                obscureText: true,
                // suffixForObscureText: (_) => Container(),
                onChanged: (_) {}),
            Container(height: 50),
            TextField(obscureText: true),
          ]));
}
