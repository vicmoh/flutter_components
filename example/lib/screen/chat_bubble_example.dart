import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

class ChatBubbleExample extends StatefulWidget {
  ChatBubbleExample({Key key}) : super(key: key);

  @override
  _ChatBubbleExampleState createState() => _ChatBubbleExampleState();
}

class _ChatBubbleExampleState extends State<ChatBubbleExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: <Widget>[_chat(), _chat(), _chat(), _chat()]));
  }

  Widget _chat() => Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
      child: ChatBubble(
        fontWeight: FontWeight.w500,
        headerFontWeight: FontWeight.bold,
        isOnTheLeftSide: true,
        message: "Text messaging, or texting," +
            "is the act of composing and " +
            "sending electronic messages, typically consisting of " +
            "alphabetic and numeric characters, between two or more  " +
            "users of mobile devices, desktops/laptops, " +
            "or other type of compatible computer. Text messages " +
            "may be sent over a cellular network, or " +
            "may also be sent via an Internet connection."
                .replaceAll(RegExp('\n\t'), ''),
        backgroundColor: Color.fromRGBO(230, 230, 240, 1),
        borderRadius: 15,
        messageTextScaleSize: 1.2,
        displayNameInHeader: false,
        headerText: 'Pinicle Pickle - 6h',
        headerColor: Colors.pink,
        textColor: Colors.black87,
      ));
}
