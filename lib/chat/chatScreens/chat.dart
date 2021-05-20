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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/study-pal-1187e.appspot.com/o/DSC05392.JPG?alt=media&token=c87cff17-9f4a-4c01-a30e-90cfaf322add"),
          ),
        ),

        // backgroundColor: MyConstants.appBarColor,
        backgroundColor: Colors.amber,
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
