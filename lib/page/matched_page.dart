import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_pal/provider/userData.dart';
import 'package:study_pal/widget/home_tile.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Study Pal'),
        backgroundColor: Colors.amber,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    // List of users here !
                    .where(
                      'uid',
                      whereIn: userDataProvider.likedBy.isEmpty
                          ? null
                          : userDataProvider.likedBy,
                    )
                    .limit(_limit)
                    .snapshots(),
                builder: (context, snapshot) {
                  try {
                    if (snapshot.data!.docs.length < 1) {
                      return Center(child: Text("no users"));
                    } else {
                      if (!snapshot.hasData) {
                        return Center(child: Text("no other users"));
                      } else {
                        // print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                        // print('!!!!!');
                        // print(snapshot.data!.docs.length);
                        return ListView.builder(
                          controller: listScrollController,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return HomeTile(
                                peer: snapshot.data!.docs[index],
                                items: snapshot.data!.docs);
                          },
                        );
                      }
                    }
                  } catch (e) {
                    return Center(child: Text("no users"));
                  }
                }),
          ),
          // Loading
        ],
      ),
    );
  }
}
