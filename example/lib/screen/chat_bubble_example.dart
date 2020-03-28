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
      body: ListView(
        children: <Widget>[_chat()],
      ),
    );
  }

  Widget _chat() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChatBubble(
          borderRadius: 30,
          isOnTheLeftSide: true,
          message: 'Testing this message',
          backgroundColor: Colors.pink));
}
