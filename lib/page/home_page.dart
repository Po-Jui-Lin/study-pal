import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:study_pal/widget/home_tiles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;

  void scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent && !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Pal'),
        backgroundColor: Colors.amber,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').limit(_limit).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("no other users"));
                  } else {
                    return ListView.builder(
                      controller: listScrollController,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return UserTile(peer: snapshot.data.docs[index], items: snapshot.data.docs);
                      },
                    );
                  }
                }),
          ),
          // Loading
        ],
      ),
    );
  }
}

// class UserTile extends StatefulWidget {
//   final QueryDocumentSnapshot user;
//   final List items;
//   final int index;
//   UserTile({this.user, this.items, this.index});

//   @override
//   _UserTileState createState() => _UserTileState();
// }

// class _UserTileState extends State<UserTile> {
//   @override
//   Widget build(BuildContext context) {
//     // return Text(user["name"]);

//     return Padding(
//       padding: EdgeInsets.only(top: 8.0),
//       child: Card(
//         margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//         child: Slidable(
//           actionPane: SlidableDrawerActionPane(),
//           actionExtentRatio: 0.2,
//           direction: Axis.horizontal,
//           child: ListTile(
//             // leading: CircleAvatar(
//             //   radius: 25.0,
//             //   backgroundImage: NetworkImage(staff.profilePic),
//             // ),
//             title: Text(widget.user["name"]),
//           ),
//           actions: <Widget>[
//             IconSlideAction(
//               caption: 'Archive',
//               color: Colors.blue,
//               icon: Icons.archive,
//               // onTap: () => _showSnackBar('Archive'),
//             ),
//           ],
//           secondaryActions: <Widget>[
//             IconSlideAction(
//               caption: 'Archive',
//               color: Colors.blue,
//               icon: Icons.archive,
//               // onTap: () => _showSnackBar('Archive'),
//             ),
//           ],
//           dismissal: SlidableDismissal(
//             child: SlidableDrawerDismissal(),
//             onDismissed: (actionType) {
//               print(actionType == SlideActionType.primary ? 'left 2 right' : 'right 2 left');
//               setState(() {
//                 items.removeAt(index);
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
