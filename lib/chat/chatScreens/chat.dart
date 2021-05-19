import 'package:flutter/material.dart';
import 'package:study_pal/chat/chatScreens/input.dart';
import 'package:study_pal/chat/chatScreens/message_list.dart';

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
              // List of messages
              MessageList(),

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
