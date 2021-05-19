import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Row timestamp(DocumentSnapshot document, bool self) {
  return Row(
    mainAxisAlignment: self ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: <Widget>[
      Container(
        child: Text(
          DateFormat('dd MMM kk:mm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(document.get('timestamp')))),
          // style: Theme.of(context).textTheme.caption,
        ),
        margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0, bottom: 5.0),
      ),
    ],
  );
}
