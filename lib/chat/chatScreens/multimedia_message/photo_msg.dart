import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

Container photoMsg(DocumentSnapshot document, BuildContext context) {
  return Container(
    child: TextButton(
      child: Material(
        child: CachedNetworkImage(
          placeholder: (context, url) => Container(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color?>(Colors.blue[700]),
            ),
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(70.0),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Material(
            child: Image.asset(
              'assets/evolproLogo.png',
              width: 200.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            clipBehavior: Clip.hardEdge,
          ),
          imageUrl: document.get('content'),
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        clipBehavior: Clip.hardEdge,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Container(
              child: PhotoView(imageProvider: CachedNetworkImageProvider(document.get('content'))),
              // child: Text(document.data()['content']),
            ),
          ),
        );
      },
    ),
    margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
  );
}
