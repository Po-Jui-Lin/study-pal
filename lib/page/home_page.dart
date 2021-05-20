import 'package:flutter/material.dart';

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
      body: Column(
        children: <Widget>[
          Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('staff').limit(_limit).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("no other users"));
                  } else {
                    return ListView.builder(
                      controller: listScrollController,
                      itemCount: snapshot.length,
                      itemBuilder: (context, index) {
                        return StaffTile(staff: snapshot[index]);
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
