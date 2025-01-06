import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Coffee"),
        backgroundColor: Colors.brown[700],
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: Colors.blueAccent,
          // width: 100,
          // height: 100,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(left: 150),
          child: Text(
            "Text Example",
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 4,
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
