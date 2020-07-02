import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: <Widget>[
              _chat(), 
              _chat(
                  replyHeader: ChatBubble.defaultReplyHeader(),
                  replyMessage: ChatBubble.defaultReplyMessage('Hello World!')),
              _chat(
                  replyColor: Colors.red,
                  isReplyHeaderOutside: true,
                  replyHeader: ChatBubble.defaultReplyHeader(iconColor: Colors.grey,
                      style: TextStyle(color: Colors.grey)),
                  replyMessage: ChatBubble.defaultReplyMessage('Hello World!')),
              _chat(
                  replyColor: Color.fromRGBO(240, 240, 240, 1),
                  isReplyHeaderOutside: true,
                  replyHeader: ChatBubble.defaultReplyHeader(iconColor: Colors.black,
                      style: TextStyle(color: Colors.black)),
                  replyMessage: ChatBubble.defaultReplyMessage('Hello World!', 
                      dividerColor: Colors.black,
                      style:TextStyle(color: Colors.black))),
            ]));
  }

  Widget _chat({replyMessage, replyHeader, isReplyHeaderOutside = false, replyColor}) => Container(
          child: ChatBubble(
        fontWeight: FontWeight.w500,
        headerFontWeight: FontWeight.bold,
        isOnTheLeftSide: true,
        avatarAlignment: CrossAxisAlignment.end,
        avatarUrl:
            'https://vignette.wikia.nocookie.net/blinks/images/d/d3/Lisa_Infobox.PNG',
        showAvatar: true,
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
        backgroundGradient: LinearGradient(colors: [
          Colors.green[200],
          Colors.yellow[200],
        ]),
        replyBackgroundColor: replyColor,
        isReplyHeaderOutside: isReplyHeaderOutside,
        onReplyTap: () => toast('Reply is tapped.'),
        replyMessage: replyMessage, 
        replyHeader: replyHeader,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30)),
        messageTextScaleSize: 1.2,
        displayNameInHeader: false,
        headerText: 'Pinicle Pickle - 6h',
        headerColor: Colors.pink,
        textColor: Colors.black87,
      ));
}
