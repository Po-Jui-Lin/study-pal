import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_pal/chat/chatScreens/message.dart';

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
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
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
    final String groupId =
        "mwU8cQ1IX9gu6RXLNvF9AHJNYDm1-sW7nZtffcdRXrZN9HMNF3FLSw692"; //temp

    return Flexible(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('message')
            .doc(groupId)
            .collection(groupId)
            .orderBy('timestamp', descending: true)
            .limit(_limit)
            .snapshots(),
        builder: (context, snapshot) {
          try {
            if (snapshot.data!.docs.length == 0) {
              return Center(child: Text("no message"));
            } else {
              listMessage.addAll(snapshot.data!.docs);
              return ListView.builder(
                padding: EdgeInsets.all(10.0),
                // itemBuilder: (context, index) => message(context, index, snapshot.data.docs[index], user, widget.peer),
                itemBuilder: (context, index) => message(
                    context,
                    index,
                    snapshot.data!.docs[index],
                    "mwU8cQ1IX9gu6RXLNvF9AHJNYDm1",
                    "sW7nZtffcdRXrZN9HMNF3FLSw692"),
                // itemBuilder: (context, index) => Text(index.toString() + snapshot.data.documents[index].toString()),

                itemCount: snapshot.data!.docs.length,
                reverse: true,
                controller: listScrollController,
              );
            }
          } catch (e) {
            return Center(child: Text("no message"));
          }
        },
      ),
    );
  }
}
