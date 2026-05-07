import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text("To Do List")),
          leading: Icon(Icons.menu),
          actions: [Icon(Icons.search)],
        ),
        body: Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: Text("To do App", style: TextStyle(fontSize: 30)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
