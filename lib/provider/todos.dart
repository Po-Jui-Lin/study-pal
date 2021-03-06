import 'package:flutter/cupertino.dart';
import 'package:study_pal/api/firebase_api.dart';
import 'package:study_pal/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo>? _todos = [];

  List<Todo>? get todos => _todos;

  void setTodos(List<Todo>? todos) =>
      // to make sure that this is executed after the build method inside todo_page.dart
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  void removeTodo(Todo todo, context) => FirebaseApi.deleteTodo(todo);

  bool? toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone!;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String? title, String? description) {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo);
  }
}
