import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

class StackAvatarsExample extends StatefulWidget {
  StackAvatarsExample({Key key}) : super(key: key);

  @override
  _StackAvatarsExampleState createState() => _StackAvatarsExampleState();
}

class _StackAvatarsExampleState extends State<StackAvatarsExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: StackAvatars(
          imageSize: 100,
          imageUrls: [
            'https://miro.medium.com/max/1400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg'
          ],
          imagePlaceholderPath: 'assets/ethos-logo.png',
        ),
      ),
    );
  }
}
