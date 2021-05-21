import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_pal/api/firebase_api.dart';
import 'package:study_pal/provider/google_sign_in.dart';
import 'package:study_pal/provider/userData.dart';
import 'package:study_pal/widget/home_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController listScrollController = ScrollController();
  bool isLoading = true;
  bool gotData = false;
  bool isLoggedIn = false;

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
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      isLoggedIn = true;
      getUserData();
    } else {
      isLoggedIn = false;
      isLoading = false;
    }
  }

  Future<void> getUserData() async {
    final data = await FirebaseApi.getUserData();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    // print(data);
    userProvider.likedBy = data!['likedBy'] ?? [];
    userProvider.usersLiked = data['usersLiked'] ?? [];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the Google Sign In Provider so that this re-renders when user logs in
    final googleLogin = Provider.of<GoogleSignInProvider>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);

    // Get data if user Signs in, initState is not called again, so we need to manually do this
    if (!gotData) {
      getUserData();
      gotData = true;
    } else {
      isLoading = false;
    }
    // print('========================================');
    // print(userDataProvider.usersLiked);
    // print('========================================');

    return Scaffold(
      appBar: AppBar(
        title: Text('Study Pal'),
        backgroundColor: Colors.amber,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : !isLoggedIn
              ? Center(
                  child: Text(
                    'Please log in first!',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Stack(
                  children: <Widget>[
                    Container(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where('uid',
                                  whereNotIn:
                                      userDataProvider.usersLiked.isEmpty
                                          ? null
                                          : userDataProvider.usersLiked)
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
