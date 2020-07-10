import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

class LinkPreviewExample extends StatefulWidget {
  LinkPreviewExample({Key key}) : super(key: key);

  @override
  LinkPreviewExampleState createState() => LinkPreviewExampleState();
}

class LinkPreviewExampleState extends State<LinkPreviewExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          LinkPreview(
              onTap: () {},
              backgroundColor: Color.fromRGBO(230, 230, 230, 1),
              url:
                  "https://ichef.bbci.co.uk/news/1024/branded_news/689D/production/_113318762_gettyimages-635967265.jpg",
              title:
                  "Robotics Expert Breaks Down 13 Robot Scenes From Film & TV | WIRED",
              description:
                  "Chris Atkeson, a professor at the Robotics Institute at Carnegie Mellon University, watches more scenes featuring robots from movies and television and conti..."),
          Padding(
              padding: const EdgeInsets.all(30),
              child: LinkPreview.bubble(
                  onTap: () {},
                  backgroundColor: Color.fromRGBO(230, 230, 230, 1),
                  url:
                      "https://ichef.bbci.co.uk/news/1024/branded_news/689D/production/_113318762_gettyimages-635967265.jpg",
                  title:
                      "Robotics Expert Breaks Down 13 Robot Scenes From Film & TV | WIRED",
                  description:
                      "Chris Atkeson, a professor at the Robotics Institute at Carnegie Mellon University, watches more scenes featuring robots from movies and television and conti...")),
          Padding(
              padding: const EdgeInsets.all(30),
              child: LinkPreview.bubble(
                  onTap: () {},
                  isLinkAtBottom: true,
                  backgroundColor: Color.fromRGBO(230, 230, 230, 1),
                  padding: const EdgeInsets.only(bottom: 5),
                  url:
                      "https://ichef.bbci.co.uk/news/1024/branded_news/689D/production/_113318762_gettyimages-635967265.jpg",
                  title:
                      "Robotics Expert Breaks Down 13 Robot Scenes From Film & TV | WIRED",
                  description:
                      "Chris Atkeson, a professor at the Robotics Institute at Carnegie Mellon University, watches more scenes featuring robots from movies and television and conti...")),
          Padding(
              padding: const EdgeInsets.all(30),
              child: LinkPreview.bubble(
                  elevation: 10,
                  onTap: () {},
                  isLinkAtBottom: true,
                  backgroundColor: Color.fromRGBO(230, 230, 230, 1),
                  padding: const EdgeInsets.only(bottom: 5),
                  url:
                      "https://ichef.bbci.co.uk/news/1024/branded_news/689D/production/_113318762_gettyimages-635967265.jpg",
                  title:
                      "Robotics Expert Breaks Down 13 Robot Scenes From Film & TV | WIRED",
                  description:
                      "Chris Atkeson, a professor at the Robotics Institute at Carnegie Mellon University, watches more scenes featuring robots from movies and television and conti...")),
        ],
      ),
    );
  }
}
