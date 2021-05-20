import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserTile extends StatefulWidget {
  final QueryDocumentSnapshot peer;
  final List items;

  UserTile({this.peer, this.items});

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // return Text(user["name"]);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Slidable(
          key: Key(widget.peer.id),
          // key: UniqueKey(),
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.2,
          direction: Axis.horizontal,
          child: ListTile(
            // leading: CircleAvatar(
            //   radius: 25.0,
            //   backgroundImage: NetworkImage(staff.profilePic),
            // ),
            title: Text(widget.peer["name"]),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Archive',
              color: Colors.blue,
              icon: Icons.archive,
              // onTap: () => _showSnackBar('Archive'),
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Archive',
              color: Colors.blue,
              icon: Icons.archive,
              // onTap: () => _showSnackBar('Archive'),
            ),
          ],
          dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(),
            onDismissed: (actionType) async {
              Fluttertoast.showToast(msg: actionType == SlideActionType.primary ? 'left 2 right' : 'right 2 left');
              await FirebaseFirestore.instance.collection('users').doc(widget.peer.id).update({
                "todayMatchedWith": currentUser.uid,
              });
              await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
                "todayMatchedWith": widget.peer.id,
              });
              widget.items.remove(widget.peer.id);
            },
          ),
        ),
      ),
    );
  }
}
