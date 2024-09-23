import 'package:flutter/material.dart';
import 'package:min_project/page1.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _Todostate();
}

class _Todostate extends State<Todo> with SingleTickerProviderStateMixin {
  // Animation controller for fade-in effect
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Animation duration
    );
    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      body: Column(
        //verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              height: 270,
              width: 600,
              child: const Image(
                image: NetworkImage(
                  'https://marketplace.canva.com/EAFO2zQwVFM/1/0/1131w/canva-beige-minimalist-to-do-list-planner-d9c2bZvUNHY.jpg',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeTransition(
            opacity: _fadeInAnimation, // Apply fade-in effect to the text
            child: const Column(children: [
              Text(
              "Welcome to Todo List App",
              style: TextStyle(
                color: Colors.white, // White text for contrast
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
             const SizedBox(height: 10),
            Text(
              "“The best way to predict the future is to create it.” – Peter Drucker",
              style: TextStyle(
                color: Color.fromARGB(255, 130, 236, 220), // White text for contrast
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            ]
            ),
            
          ),
          const SizedBox(height: 40),
           // Add some spacing
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(213, 253, 255, 255),
              backgroundColor: const Color.fromARGB(231, 38, 38, 38),
              minimumSize: const Size(200, 50),
            ),
            onPressed: () {
              // Action when "Get Started" button is pressed
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FirstPage()), // Navigate to FirstPage
              );
            },
            child: const Text("Get Started"),
          ),
          const SizedBox(height: 40), // More spacing
        ],
      ),
    );
  }
}
