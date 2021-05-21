import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeTile extends StatefulWidget {
  final QueryDocumentSnapshot peer;
  final List items;

  HomeTile({required this.peer, required this.items});

  @override
  _HomeTileState createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    // DocumentReference<Map<String, dynamic>> peerTodo = FirebaseFirestore.instance.collection('users').doc(widget.peer.id).collection("todoList").doc().;
    // return Text(user["name"]);

    if (widget.peer.id != currentUser.uid) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(widget.peer.id).collection("todoList").snapshots(),
        builder: (context, snapshot) {
          print(snapshot.data.toString());
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
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/study-pal-1187e.appspot.com/o/DSC05392.JPG?alt=media&token=c87cff17-9f4a-4c01-a30e-90cfaf322add"),
                  ),
                  title: Text(widget.peer["name"]),
                  // subtitle:
                  // Text(snapshot.data!.docs[0].get("title").toString()),
                  //     ListView.builder(
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) => Text(snapshot.data!.docs["title"]),
                  //   itemCount: snapshot.data!.docs.length,
                  // ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Accept',
                    color: Colors.blue,
                    icon: Icons.archive,
                    // onTap: () async {
                    //   Fluttertoast.showToast(msg: "accept");
                    //   await FirebaseFirestore.instance.collection('users').doc(widget.peer.id).update({
                    //     "todayMatchedWith": currentUser.uid,
                    //   });
                    //   await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
                    //     "todayMatchedWith": widget.peer.id,
                    //   });
                    // },
                    // onTap: () => ,
                  ),
                ],
                // secondaryActions: <Widget>[
                //   IconSlideAction(
                //     caption: 'Reject',
                //     color: Colors.blue,
                //     icon: Icons.archive,
                //     onTap: () {
                //       Fluttertoast.showToast(msg: "reject");
                //       setState(() {
                //         widget.items.remove(widget.peer.id);
                //       });
                //     },
                //   ),
                // ],
                // dismissal: SlidableDismissal(
                //   child: SlidableDrawerDismissal(),
                // onDismissed: (actionType) async {
                //   Fluttertoast.showToast(msg: actionType == SlideActionType.primary ? 'left 2 right' : 'right 2 left');
                //   await FirebaseFirestore.instance.collection('users').doc(widget.peer.id).update({
                //     "todayMatchedWith": currentUser.uid,
                //   });
                //   await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
                //     "todayMatchedWith": widget.peer.id,
                //   });
                //   widget.items.remove(widget.peer.id);
                // },
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
