import 'package:flutter/material.dart';
// import 'package:coffee_card/home.dart';

void main() {
  runApp(const MaterialApp(
    home: Sandbox(),
  ));
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sandbox"),
          backgroundColor: Colors.grey,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(),
              Container(
                height: 500,
                color: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 1,
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      color: Colors.grey,
                      child: Center(
                          child: const Text(
                        "0",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                    Container(
                      height: 50,
                      color: Colors.black,
                      child: Row(
                        spacing: 1,
                        children: [
                          Container(
                            color: Colors.grey,
                            width: 100,
                            child: Center(
                                child: const Text(
                              ",",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          Container(
                            color: Colors.deepOrange,
                            width: 100,
                            child: Center(
                                child: const Text(
                              "=",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
