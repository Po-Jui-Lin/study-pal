import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:study_pal/model/todo.dart';
import 'package:study_pal/utils.dart';
import 'dart:async';

import 'package:study_pal/provider/google_sign_in.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo, BuildContext context) async {
    final googleProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(googleProvider.user!.id)
        .collection('todo')
        .doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos(BuildContext context) {
    final googleProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    return FirebaseFirestore.instance
        .collection('users')
        .doc(googleProvider.user!.id)
        .collection('todo')
        .orderBy(TodoField.createdTime, descending: true)
        .snapshots()
        .transform(Utils.transformer(Todo.fromJson) as StreamTransformer<
            QuerySnapshot<Map<String, dynamic>>, List<Todo>>);
  }

  static Future updateTodo(Todo todo, BuildContext context) async {
    final googleProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(googleProvider.user!.id)
        .collection('todo')
        .doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo, BuildContext context) async {
    final googleProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);

    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(googleProvider.user!.id)
        .collection('todo')
        .doc(todo.id);

    await docTodo.delete();
  }
}
