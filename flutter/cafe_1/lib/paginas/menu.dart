import 'package:cafe_1/paginas_menu/lavado.dart';
import 'package:cafe_1/paginas_menu/sensor.dart';
import 'package:cafe_1/paginas_menu/tanque.dart';
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(125, 224, 150, 1),
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Image.asset('assets/tanque.png'),
            title: Text('Tanque'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Tanque(),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset('assets/sproximidad.png'),
            title: Text('Sensor Proximidad'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SensorP(),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset('assets/lavado.png'),
            title: Text('Lavado'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Lavado(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
