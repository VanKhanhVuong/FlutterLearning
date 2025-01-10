// import 'package:coffee_card/home.dart';
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
              Container(
                height: 500,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 1,
                  children: [
                    // AC | +/- | % | /
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 1,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("AC Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "AC",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("+/- Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "+/-",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("% Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "%",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("/ Tapped");
                              },
                              child: Container(
                                color: Colors.deepOrange,
                                child: Center(
                                    child: const Text(
                                  "/",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 7 | 8 | 9 | x
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 1,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("7 Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "7",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("8 Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "8",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("9 Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "9",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("X Tapped");
                              },
                              child: Container(
                                color: Colors.deepOrange,
                                child: Center(
                                    child: const Text(
                                  "x",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 4 | 5 | 6 | -
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 1,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("4 Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "4",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("5 Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "5",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("6 Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "6",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("- Tapped");
                              },
                              child: Container(
                                color: Colors.deepOrange,
                                child: Center(
                                    child: const Text(
                                  "-",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 1 | 2 | 3 | +
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 1,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("1 Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "1",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("2 Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "2",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("3 Tapped");
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                    child: const Text(
                                  "3",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("+ Tapped");
                              },
                              child: Container(
                                color: Colors.deepOrange,
                                child: Center(
                                    child: const Text(
                                  "+",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //   0   | , | =
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 1,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("0 Tapped");
                              },
                              child: Container(
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
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.black,
                              child: Row(
                                spacing: 1,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        print(", Tapped");
                                      },
                                      child: Container(
                                        color: Colors.grey,
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
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        print("= Tapped");
                                      },
                                      child: Container(
                                        color: Colors.deepOrange,
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
