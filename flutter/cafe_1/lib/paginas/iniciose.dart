import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Registro'),
      ),
      body: new Column(
        children: <Widget>[new Text('Estamos en Registro')],
      ),
    );
  }
}
