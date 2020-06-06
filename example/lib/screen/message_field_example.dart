import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

class MessageFieldExample extends StatefulWidget {
  MessageFieldExample({Key key}) : super(key: key);

  @override
  _MessageFieldExampleState createState() => _MessageFieldExampleState();
}

class _MessageFieldExampleState extends State<MessageFieldExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(child: Container()),
          MessageField(
            maxLength: 20,
            onFieldChanged: (val) {},
            onSend: () {},
            backgroundColor: Theme.of(context).primaryColor,
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
