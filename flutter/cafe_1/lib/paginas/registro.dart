import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registro(), // Set the home property to Menu class
    );
  }
}

class Registro extends StatelessWidget {
//registro de usuario para la BD
  TextEditingController cedulaController = TextEditingController();
  TextEditingController nombre1Controller = TextEditingController();
  TextEditingController nombre2Controller = TextEditingController();
  TextEditingController apellido1Controller = TextEditingController();
  TextEditingController apellido2Controller = TextEditingController();
  TextEditingController residenciaController = TextEditingController();
  TextEditingController clavedeaccesoController = TextEditingController();

  late List data;

  Future<List> getData() async {
    final response =
        await http.post(Uri.parse("http://192.168.26.13:8090/users"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuarios'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cedulaController,
                    decoration: InputDecoration(
                      labelText: 'Cédula',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nombre1Controller,
                    decoration: InputDecoration(
                      labelText: 'Nombre 1',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nombre2Controller,
                    decoration: InputDecoration(
                      labelText: 'Nombre 2',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: apellido1Controller,
                    decoration: InputDecoration(
                      labelText: 'Apellido 1',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: apellido2Controller,
                    decoration: InputDecoration(
                      labelText: 'Apellido 2',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: residenciaController,
                    decoration: InputDecoration(
                      labelText: 'Residencia',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: clavedeaccesoController,
                    decoration: InputDecoration(
                      labelText: 'Clave de acceso',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: Text("Registrar"),
                    onPressed: () {
                      getData();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
