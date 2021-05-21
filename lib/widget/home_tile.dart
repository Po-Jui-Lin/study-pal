import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:study_pal/provider/userData.dart';

class HomeTile extends StatefulWidget {
  final QueryDocumentSnapshot peer;
  final List items;

  HomeTile({required this.peer, required this.items});

  @override
  _HomeTileState createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      currentUser = FirebaseAuth.instance.currentUser!;
    } else {
      currentUser = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // DocumentReference<Map<String, dynamic>> peerTodo = FirebaseFirestore.instance.collection('users').doc(widget.peer.id).collection("todoList").doc().;
    // return Text(user["name"]);

    if (currentUser == null) {
      return SizedBox();
    }
    // print(widget.peer.id);
    // print(currentUser!.uid);

    if (widget.peer.id != currentUser!.uid) {
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.peer.id)
            .collection('todo')
            .snapshots(),
        builder: (context, snapshot) {
          // print('========================');
          // print(widget.peer.data());
          // snapshot.data!.docs.forEach((element) {
          //   print('======================');
          //   print(element.data());
          //   print('======================');
          // });
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
                    backgroundImage: NetworkImage((widget.peer.data()
                            as Map<String, dynamic>)['photo'] ??
                        // If no photo, default one:
                        'https://firebasestorage.googleapis.com/v0/b/study-pal-1187e.appspot.com/o/DSC05392.JPG?alt=media&token=c87cff17-9f4a-4c01-a30e-90cfaf322add'),
                  ),
                  title: Text(
                      (widget.peer.data() as Map<String, dynamic>)['name'] ??
                          // If no username exists: empy string
                          ''),
                  subtitle:
                      //     // Text(snapshot.data.docs[0].get("title").toString()),
                      ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        Text(snapshot.data!.docs[index].data()['title'] ?? ''),
                    itemCount:
                        snapshot.hasData ? snapshot.data!.docs.length : 0,
                  ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Like',
                    color: Colors.blue,
                    icon: Icons.done,
                    onTap: () async {
                      // print('Liking:');
                      // print(widget.peer.id);
                      final userDataProvider =
                          Provider.of<UserDataProvider>(context, listen: false);
                      userDataProvider.addUsersLiked(widget.peer.id);
                      Fluttertoast.showToast(msg: 'accept');
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.peer.id)
                          .update({
                        'likedBy': FieldValue.arrayUnion([currentUser!.uid]),
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUser!.uid)
                          .update({
                        'todayMatchedWith': widget.peer.id,
                        'usersLiked': FieldValue.arrayUnion([widget.peer.id])
                        // FieldValue.arrayUnion([widget.peer.id]),
                      });
                    },
                  ),
                ],
                // secondaryActions: <Widget>[
                //   IconSlideAction(
                //     caption: 'Dismiss',
                //     color: Colors.blue,
                //     icon: Icons.close_outlined,
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
