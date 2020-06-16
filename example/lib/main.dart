import 'package:example/screen/button_examples.dart';
import 'package:example/screen/chat_bubble_example.dart';
import 'package:example/screen/message_field_example.dart';
import 'package:example/screen/stack_avatars_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/screen/smart_text_example.dart';
import 'package:example/screen/animate_example.dart';

import 'screen/phone_field_example.dart';
import 'package:flutter_components/flutter_components.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Widget examples',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _btnNav(text, screen) => RaisedButton(
      child: Text(text),
      onPressed: () =>
          Navigator.push(context, CupertinoPageRoute(builder: (_) => screen)));

  _btn(text, onPressed) =>
      RaisedButton(child: Text(text), onPressed: onPressed);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Widget")),
      body: Center(
        child: ListView(children: <Widget>[
          /// testing elevation for custom field
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomField.round(
                  elevation: 10,
                  prefixIcon:
                      Icon(Icons.search, color: Theme.of(context).primaryColor),
                  backgroundColor: Colors.white,
                  onChanged: (val) {})),

          /// Button for testing stack avatars
          _btnNav('Stack avatar example', StackAvatarsExample()),

          /// button test for phone field example
          _btnNav('Phone field example', PhoneFieldExample()),

          /// Example for the message field.
          _btnNav('Message field example', MessageFieldExample()),

          /// Chat bubble example.
          _btnNav('Chat bubble example', ChatBubbleExample()),

          /// Testing buttons
          _btnNav('Buttons example', ButtonExamples()),

          /// Smart text example
          _btnNav('Smart text', SmartTextExample()),

          /// Animate example
          _btnNav('Animate example', AnimateExample()),

          /// Testing full screen popup
          _btn(
              'Fullscreen popup',
              () => FullScreenPopupView.show(context,
                  disableSwipeToExit: false,
                  builder: (_) => Center(child: Text('Test')))),
        ]),
      ));
}
