import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

ClipRRect fileMsg(DocumentSnapshot document) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(
          Icons.insert_drive_file,
          color: Colors.blue[400],
          size: 60.0,
        ),
        Container(
          height: 40,
          child: IconButton(
            icon: Icon(
              Icons.open_in_browser,
              color: Colors.blue[500],
            ),
            onPressed: () async {
              String _url = document.get('content');
              await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
            },
          ),
        )
      ],
    ),
  );
}
