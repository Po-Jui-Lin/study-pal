import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_pal/model/todo.dart';
import 'package:study_pal/utils.dart';
import 'dart:async';

class FirebaseApi {
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
