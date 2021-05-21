import 'package:flutter/material.dart';

class PopupTodo extends StatefulWidget {
  final String peer;

  PopupTodo({required this.peer});
  @override
  _PopupTodoState createState() => _PopupTodoState();
}

class _PopupTodoState extends State<PopupTodo> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Todo List of ' + widget.peer),
      content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Back'),
          child: const Text('Back'),
        ),
      ],
    );
  }
}
