import 'package:flutter/material.dart';
import 'package:quizu/pages/quiz.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Expanded(
            child: Card(
              child: SizedBox(
                width: double.maxFinite,
                child: Center(
                  child: Text(
                    """Ready to test your\nknoweldge and challenge\nothers?""",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: double.maxFinite,
            height: 80,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Quiz(),
                  ),
                );
              },
              child: const Text("Quiz Me!"),
            ),
          ),
          const Expanded(
            child: Card(
              child: SizedBox(
                width: double.maxFinite,
                child: Center(
                  child: Text(
                    """Answer as much questions\ncorrectly within 2 minutes""",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
