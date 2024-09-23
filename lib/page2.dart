import 'package:flutter/material.dart';
import 'package:min_project/class.dart';

class SecondPage extends StatefulWidget {
  final Mytodo? todo;

  const SecondPage({Key? key, this.todo}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo?.title);
    descriptionController = TextEditingController(text: widget.todo?.description);
  }

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Text(
                    "Create or Edit Task",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Task Name", style: TextStyle(color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      hintText: "Enter title",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.black54,
                      contentPadding: EdgeInsets.all(16), // Add padding here
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Task Description", style: TextStyle(color: Colors.white)),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      hintText: "Enter description",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.black54,
                      contentPadding: EdgeInsets.all(16), // Add padding here
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final newTodo = Mytodo(
                          title: titleController.text,
                          id: widget.todo?.id ?? DateTime.now().millisecondsSinceEpoch,
                          description: descriptionController.text,
                          iscomplete: widget.todo?.iscomplete ?? false,
                        );
                        Navigator.pop(context, newTodo);
                      },
                      child: const Text('Save Task'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(222, 11, 11, 11),
                        backgroundColor: Color.fromARGB(210, 220, 217, 217),
                        minimumSize: const Size(5, 50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
