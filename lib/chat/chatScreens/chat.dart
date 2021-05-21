import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_pal/chat/chatScreens/input.dart';
import 'package:study_pal/chat/chatScreens/message_list.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    String currentUID = currentUser.uid;

    // if (snapshot.data!.data()!["todayMatchedWith"] != null) {
    if (true) {
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
    } else {
      return Center(child: Text("You don't have a match for today yet"));
    }
    // },
//     );
//   }
  }
}
