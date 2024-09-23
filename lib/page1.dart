import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:min_project/class.dart';
import 'package:min_project/page2.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.network(
              'https://th.bing.com/th/id/OIP.i2TtfT1dfC9xFyLuGKJVFAHaFL?rs=1&pid=ImgDetMain',
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Task List",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Consumer<Todolist>(
                builder: (context, todolist, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: todolist.todos.length,
                    itemBuilder: (context, index) {
                      final todo = todolist.todos[index];
                      return Card(
                        color: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          leading: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Checkbox(
                              checkColor: Colors.black,
                              activeColor: Colors.white,
                              value: todo.iscomplete,
                              onChanged: (value) {
                                todolist.toggleComplete(todo.id);
                              },
                            ),
                          ),
                          title: Text(
                            todo.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            todo.description,
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.white,
                                onPressed: () async {
                                  final updatedTodo = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SecondPage(todo: todo),
                                    ),
                                  );

                                  if (updatedTodo != null && updatedTodo is Mytodo) {
                                    todolist.updateTodo(updatedTodo);
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.white,
                                onPressed: () {
                                  todolist.removeTodo(todo.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTodo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondPage()),
          );

          if (newTodo != null && newTodo is Mytodo) {
            final todolist = Provider.of<Todolist>(context, listen: false);
            if (!todolist.todos.any((todo) => todo.id == newTodo.id)) {
              todolist.addTodo(newTodo);
            }
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
