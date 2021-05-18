import 'package:flutter/material.dart';
import 'package:study_pal/chat/chatScreens/input.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("peer.name"),
        // backgroundColor: MyConstants.appBarColor,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("hello"),
              // List of messages
              // MessageList(peer: peer),

              // Input content
              input(),
            ],
          ),

          // Loading
          // buildLoading()
        ],
      ),
    );
  }
}
