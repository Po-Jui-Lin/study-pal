import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_pal/widget/home_tile.dart';

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
                  try {
                    if (snapshot.data.docs.length < 1) {
                      return Center(child: Text("no users"));
                    } else {
                      if (!snapshot.hasData) {
                        return Center(child: Text("no other users"));
                      } else {
                        return ListView.builder(
                          controller: listScrollController,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return HomeTile(peer: snapshot.data.docs[index], items: snapshot.data.docs);
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
