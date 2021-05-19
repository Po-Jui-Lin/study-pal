import 'package:flutter/material.dart';
import 'package:study_pal/chat/service/send_text.dart';

// Widget input(User user, Staff peer) {
Widget input() {
  final TextEditingController textEditingController = TextEditingController();

  return Container(
    child: Row(
      children: <Widget>[
        // Button send image
        Material(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            child: IconButton(
              icon: Icon(Icons.image),
              // onPressed: () => sendImage(user.uid, peer.firebaseId),
              color: Colors.black,
            ),
          ),
          color: Colors.white,
        ),
        Material(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            child: IconButton(
              icon: Icon(Icons.attach_file),
              // onPressed: () => sendFile(user.uid, peer.firebaseId),
              color: Colors.black,
            ),
          ),
          color: Colors.white,
        ),

        // Edit text
        Flexible(
          child: Container(
            child: TextField(
              onSubmitted: (value) {
                // send(textEditingController.text, 0, user.uid, peer.firebaseId, textEditingController);
                send(textEditingController.text, 0, "mwU8cQ1IX9gu6RXLNvF9AHJNYDm1", "sW7nZtffcdRXrZN9HMNF3FLSw692", textEditingController);
              },
              style: TextStyle(color: Colors.black, fontSize: 15.0),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Colors.black),
              ),
              // focusNode: focusNode,
            ),
          ),
        ),

        // Button send message
        Material(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => send(textEditingController.text, 0, "mwU8cQ1IX9gu6RXLNvF9AHJNYDm1", "sW7nZtffcdRXrZN9HMNF3FLSw692", textEditingController),
              color: Colors.black,
            ),
          ),
          color: Colors.white,
        ),
      ],
    ),
    width: double.infinity,
    height: 50.0,
    decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 0.5)), color: Colors.white),
  );
}
