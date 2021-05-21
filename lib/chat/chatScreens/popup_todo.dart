import 'package:flutter/material.dart';

class PopupTodo extends StatefulWidget {
  final String peer;

  PopupTodo({required this.peer});
  @override
  _PopupTodoState createState() => _PopupTodoState();
}

class _PopupTodoState extends State<PopupTodo> {
  String peerTodo = "todo items";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Todo List of ' + widget.peer),
      content: Column(
        children: <Widget>[
          Text(peerTodo),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Back'),
          child: const Text('Back'),
        ),
      ],
    );
  }
}
