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
    print("hihi");
    return AlertDialog(
      title: Text('Todo List of ' + widget.peer),
      content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
