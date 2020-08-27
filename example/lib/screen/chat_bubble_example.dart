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
              _chat(
                  replaceDefaultReplyWidget: Transform.translate(
                      offset: Offset(0, 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChatBubble.defaultReplyHeader(
                                text: 'Replied',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                                iconColor: Colors.grey),
                            Container(
                                height: 100,
                                width: 150,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        'https://www.w3schools.com/w3css/img_lights.jpg',
                                        fit: BoxFit.cover)))
                          ]))),
              _chat(avatarUrl: null),
              _chat(
                  replyHeader: ChatBubble.defaultReplyHeader(),
                  replyMessage: ChatBubble.defaultReplyMessage('Hello World!')),
              _chat(
                  replyColor: Colors.red,
                  isReplyHeaderOutside: true,
                  replyHeader: ChatBubble.defaultReplyHeader(
                      iconColor: Colors.grey,
                      style: TextStyle(color: Colors.grey)),
                  replyMessage: ChatBubble.defaultReplyMessage('Hello World!')),
              _chat(
                  replyColor: Color.fromRGBO(240, 240, 240, 1),
                  isReplyHeaderOutside: true,
                  replyHeader: ChatBubble.defaultReplyHeader(
                      iconColor: Colors.black,
                      style: TextStyle(color: Colors.black)),
                  replyMessage: ChatBubble.defaultReplyMessage('Hello World!',
                      dividerColor: Colors.black,
                      style: TextStyle(color: Colors.black))),
              _chat(
                  replyColor: Colors.red,
                  isReplyHeaderOutside: true,
                  replyHeader: ChatBubble.defaultReplyHeader(
                      iconColor: Colors.grey,
                      style: TextStyle(color: Colors.grey)),
                  replyMessage: ChatBubble.defaultReplyMessage(
                      'Hello World! alsdn ' +
                          ' f klajsndfl asnkdl nasklnd kln' +
                          ' alksdnlfk nkln klasn klnlk an')),
              _chat(
                  hideAvatar: true,
                  isRightSide: true,
                  replyColor: Colors.red,
                  isReplyHeaderOutside: true,
                  replyHeader: ChatBubble.defaultReplyHeader(
                      iconColor: Colors.grey,
                      style: TextStyle(color: Colors.grey)),
                  replyMessage:
                      ChatBubble.defaultReplyMessage('Hello World! alsdn ')),
              _chat(
                  hideAvatar: true,
                  headerText: null,
                  isSmallMessage: true,
                  isRightSide: true,
                  replyColor: Colors.red,
                  isReplyHeaderOutside: true,
                  replyHeader: ChatBubble.defaultReplyHeader(
                      iconColor: Colors.grey,
                      style: TextStyle(color: Colors.grey)),
                  replyMessage:
                      ChatBubble.defaultReplyMessage('Hello World! alsdn ')),
            ]));
  }

  Widget _chat({
    hideAvatar = false,
    replyMessage,
    replyHeader,
    isReplyHeaderOutside = false,
    replyColor,
    isRightSide = false,
    isSmallMessage = false,
    headerText = 'Pinicle Pickle - 6h',
    avatarUrl =
        'https://vignette.wikia.nocookie.net/blinks/images/d/d3/Lisa_Infobox.PNG',
    replaceDefaultReplyWidget,
  }) =>
      Container(
          child: ChatBubble(
        replaceDefaultReplyWidget: replaceDefaultReplyWidget,
        headerFontWeight: FontWeight.bold,
        isOnTheLeftSide: !isRightSide,
        avatarAlignment: CrossAxisAlignment.end,
        avatarUrl: avatarUrl,
        showAvatar: !hideAvatar,
        showSpacingWithHiddenAvatar: true,
        message: isSmallMessage
            ? "yo"
            : "Text messaging, or texting," +
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
        borderRadius: isRightSide
            ? BorderRadius.only(
                bottomLeft: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))
            : BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30)),
        messageTextScaleSize: 1.2,
        displayNameInHeader: false,
        headerText: headerText,
      ));
}
