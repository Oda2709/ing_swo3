import 'package:flutter/material.dart';
import 'package:cafe_1/paginas/menu.dart'; // Import the Menu class

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Menu(), // Set the home property to Menu class
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Menú'),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Menú'),
          ),
        ],
      ),
    );
  }
}
