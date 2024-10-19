import 'dart:async';

import 'package:flutter/material.dart';

import 'package:todo_app_project/mainTodoPage.dart';

class spalsh extends StatefulWidget {
  const spalsh({super.key});

  @override
  State<spalsh> createState() => _spalshState();
}

class _spalshState extends State<spalsh> {
  @override
  void initState() {
    
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const mainTodopage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 94, 4, 146),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Todo App",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
