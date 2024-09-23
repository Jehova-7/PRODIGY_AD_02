import 'package:flutter/material.dart';
import 'package:min_project/class.dart';
import 'package:min_project/homepage.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
     ChangeNotifierProvider(
      create: (context) => Todolist(),
      child: const MyApp(),
    ),
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Todo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

 