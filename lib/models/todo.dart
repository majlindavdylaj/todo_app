// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  String id;
  String title;
  String description;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? completed,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        completed: completed ?? this.completed,
      );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "completed": completed,
  };
}
