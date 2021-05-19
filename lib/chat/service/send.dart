import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void send(String content, int type, String userId, String peerId, TextEditingController textEditingController) {
  final String groupId = userId.hashCode <= peerId.hashCode ? userId + '-' + peerId : peerId + '-' + userId;

  // type: 0 = text, 1 = image, 2 = sticker
  if (content.trim() != '') {
    textEditingController.clear();

    var documentReference = FirebaseFirestore.instance.collection('message').doc(groupId).collection(groupId).doc(DateTime.now().millisecondsSinceEpoch.toString());

    documentReference.set({
      'idFrom': userId,
      'idTo': peerId,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'content': content,
      'type': type,
    });

    // listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  } else {
    Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: Colors.black, textColor: Colors.red);
  }
}
