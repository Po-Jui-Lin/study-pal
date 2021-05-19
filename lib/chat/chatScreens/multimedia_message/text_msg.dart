import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Container textMsg(DocumentSnapshot document, bool self) {
  return Container(
    child: Text(
      document.get('content'),
      style: TextStyle(color: !self ? Colors.white : Colors.black),
    ),
    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
    width: 200.0,
    decoration: BoxDecoration(color: !self ? Colors.blue : Colors.blue[200], borderRadius: BorderRadius.circular(8.0)),
    margin: EdgeInsets.only(bottom: 5.0, left: 10.0),
  );
}
