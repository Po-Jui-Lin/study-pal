import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  // final Staff peer;

  // MessageList({this.peer});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  int _limit = 20;
  int _limitIncrement = 20;
  List<DocumentSnapshot> listMessage = new List.from([]);

  final ScrollController listScrollController = ScrollController();

  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent && !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    // final String groupId = user.uid.hashCode <= widget.peer.firebaseId.hashCode ? user.uid + '-' + widget.peer.firebaseId : widget.peer.firebaseId + '-' + user.uid;
    final String groupId = "mwU8cQ1IX9gu6RXLNvF9AHJNYDm1-sW7nZtffcdRXrZN9HMNF3FLSw692"; //temp
    // print(groupId);
    return Flexible(
      // child: Text(groupId),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('messages').doc(groupId).collection(groupId).orderBy('timestamp', descending: true).limit(_limit).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("no message"));
          } else {
            listMessage.addAll(snapshot.data.documents);
            return ListView.builder(
              //   scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              padding: EdgeInsets.all(10.0),
              // itemBuilder: (context, index) => message(context, index, snapshot.data.documents[index], user, widget.peer),
              // itemBuilder: (context, index) => Text(index.toString() + snapshot.data.documents[index].toString()),
              itemBuilder: (context, index) => Text(index.toString()),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
            // return Center(child: Text("haha"));
          }
        },
      ),
    );
  }
}
