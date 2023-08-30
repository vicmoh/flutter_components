import 'package:example/screen/button_examples.dart';
import 'package:example/screen/chat_bubble_example.dart';
import 'package:example/screen/link_preview_example.dart';
import 'package:example/screen/message_field_example.dart';
import 'package:example/screen/stack_avatars_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/screen/smart_text_example.dart';
import 'package:example/screen/animate_example.dart';
import 'package:example/screen/extended_text_span_example.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:example/screen/input_field_example.dart';

import 'screen/phone_field_example.dart';
import 'package:flutter_components/flutter_components.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => OverlaySupport(
      child: MaterialApp(
          title: 'Widget examples',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _btnNav(text, screen) => ElevatedButton(
      child: Text(text),
      onPressed: () =>
          Navigator.push(context, CupertinoPageRoute(builder: (_) => screen)));

  _btn(text, onPressed) =>
      ElevatedButton(child: Text(text), onPressed: onPressed);

  _showPopup() => showDialog(
      context: context,
      builder: (cxt) =>
          CustomDialog(title: 'Hello World!', bodyText: 'Some body text.'));

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

          _btnNav('Input field example', InputFieldExample()),

          _btnNav('Stack avatar example', StackAvatarsExample()),

          _btnNav('Phone field example', PhoneFieldExample()),

          _btnNav('Message field example', MessageFieldExample()),

          _btnNav('Chat bubble example', ChatBubbleExample()),

          _btnNav('Buttons example', ButtonExamples()),

          _btnNav('Smart text', SmartTextExample()),

          _btnNav('Animate example', AnimateExample()),

          _btnNav('Extended text field example', ExtendedTextSpanExample()),

          _btnNav('Link preview example', LinkPreviewExample()),

          _btn('Show simple popup', () => _showPopup()),

          /// Testing full screen popup
          _btn(
              'Fullscreen popup',
              () => FullScreenPopupView.show(context,
                  disableSwipeToExit: false,
                  builder: (_) => Center(child: Text('Test')))),
        ]),
      ));
}
