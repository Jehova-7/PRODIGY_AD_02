import 'dart:convert'; // For JSON encoding and decoding
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



// Define Mytodo class
class Mytodo {
  String title;
  int id;
  String description;
  bool iscomplete;

  Mytodo({
    required this.title,
    required this.id,
    required this.description,
    required this.iscomplete,
  });

  // Convert Mytodo to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'iscomplete': iscomplete,
    };
  }

  // Convert JSON to Mytodo
  factory Mytodo.fromJson(Map<String, dynamic> json) {
    return Mytodo(
      title: json['title'],
      id: json['id'],
      description: json['description'],
      iscomplete: json['iscomplete'],
    );
  }
}

// Define Todolist class
class Todolist extends ChangeNotifier {
  final List<Mytodo> _todos = [];
  List<Mytodo> get todos => _todos;

  Todolist() {
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString('todos') ?? '[]';
    final List<dynamic> todosList = jsonDecode(todosJson);
    _todos.clear();
    _todos.addAll(todosList.map((json) => Mytodo.fromJson(json)).toList());
    notifyListeners();
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = jsonEncode(_todos.map((todo) => todo.toJson()).toList());
    await prefs.setString('todos', todosJson);
    notifyListeners();
  }

  void addTodo(Mytodo todo) {
    _todos.add(todo);
    _saveTodos();
  }

  void removeTodo(int id) {
    _todos.removeWhere((todo) => todo.id == id);
    _saveTodos();
  }

  void toggleComplete(int id) {
    for (var todo in _todos) {
      if (todo.id == id) {
        todo.iscomplete = !todo.iscomplete;
        _saveTodos();
        break;
      }
    }
  }

  void updateTodo(Mytodo updatedTodo) {
    for (var i = 0; i < _todos.length; i++) {
      if (_todos[i].id == updatedTodo.id) {
        _todos[i] = updatedTodo;
        _saveTodos();
        break;
      }
    }
  }
}
