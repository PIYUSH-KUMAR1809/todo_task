// To parse this JSON data, do
//
//     final toDoModel = toDoModelFromMap(jsonString);

import 'dart:convert';

ToDoModel toDoModelFromMap(String str) => ToDoModel.fromMap(json.decode(str));

String toDoModelToMap(ToDoModel data) => json.encode(data.toMap());

class ToDoModel {
  List<Todo> todos;
  int total;
  int skip;
  int limit;

  ToDoModel({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ToDoModel.fromMap(Map<String, dynamic> json) => ToDoModel(
        todos: List<Todo>.from(json["todos"].map((x) => Todo.fromMap(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toMap() => {
        "todos": List<dynamic>.from(todos.map((x) => x.toMap())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Todo {
  int id;
  String todo;
  bool completed;
  int userId;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
      };
}
