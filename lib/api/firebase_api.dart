import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_pal/model/todo.dart';
import 'package:study_pal/utils.dart';

class FirebaseApi {
  static Future<void> setUserFirebase({
    required String? name,
    required String? photoUrl,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    print(user!.uid);
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
      {
        'uid': user.uid,
        'photo': photoUrl,
        'name': name,
        // 'likedBy': [],
        // 'usersLiked': [],
        // 'todayMatchedWith': '',
      },
      SetOptions(merge: true),
    );
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    return (await docUser.get()).data();
  }

  static Future<String> createTodo(Todo todo) async {
    final user = FirebaseAuth.instance.currentUser;
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('todo')
        .doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos() {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('todo')
        .orderBy(TodoField.createdTime, descending: true)
        .snapshots()
        .transform(Utils.transformer(Todo.fromJson) as StreamTransformer<
            QuerySnapshot<Map<String, dynamic>>, List<Todo>>);
  }

  static Future updateTodo(Todo todo) async {
    final user = FirebaseAuth.instance.currentUser;
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('todo')
        .doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final user = FirebaseAuth.instance.currentUser;
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('todo')
        .doc(todo.id);

    await docTodo.delete();
  }
}
