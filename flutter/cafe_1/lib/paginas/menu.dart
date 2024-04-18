import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Menú'),
      ),
      body: new Column(
        children: <Widget>[new Text('Estamos en Menu')],
      ),
    );
  }
}
