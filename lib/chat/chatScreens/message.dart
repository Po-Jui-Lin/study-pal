import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_pal/chat/chatScreens/multimedia_message/photo_msg.dart';
import 'package:study_pal/chat/chatScreens/multimedia_message/text_msg.dart';
import 'package:study_pal/chat/chatScreens/timestamp.dart';

Widget message(BuildContext context, int index, DocumentSnapshot document, String userId, String peerId) {
  // print(document.get("content"));
  if (document.get('idFrom') == userId) {
    // Right (my message)
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            // Text("hello"),
            // Text
            document.get('type') == 0
                ? textMsg(document, true)
                // Image
                : document.get('type') == 1
                    ? photoMsg(document, context)
                    //     // file
                    //     : document.data()['type'] == 2
                    //         ? fileMsg(document)
                    : Container(), // dummy else statement for error message type
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        timestamp(document, true),
      ],
    );
  } else {
    // Left (peer message)
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // Text("hello"),
              // text message
              document.get('type') == 0
                  ? textMsg(document, false)
                  // photo msg
                  : document.get('type') == 1
                      ? photoMsg(document, context)
                      //     // file type message
                      //     : document.data()['type'] == 2
                      //         ? fileMsg(document)
                      // dummy else statement for error message type
                      : Container(),
            ],
          ),
          timestamp(document, false),
        ],
      ),
    );
  }
}
