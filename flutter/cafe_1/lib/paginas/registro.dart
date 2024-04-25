import 'dart:async';
import 'package:cafe_1/services/firebase_services.dart';
import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  const Registro({
    super.key,
  });

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  TextEditingController cedulaController = TextEditingController(text: "");
  TextEditingController nombre1Controller = TextEditingController(text: "");
  TextEditingController nombre2Controller = TextEditingController(text: "");
  TextEditingController apellido1Controller = TextEditingController(text: "");
  TextEditingController apellido2Controller = TextEditingController(text: "");
  TextEditingController residenciaController = TextEditingController(text: "");
  TextEditingController clavedeaccesoController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: cedulaController,
                        decoration: const InputDecoration(
                          hintText: 'Cédula',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nombre1Controller,
                        decoration: const InputDecoration(
                          hintText: 'Nombre 1',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nombre2Controller,
                        decoration: const InputDecoration(
                          hintText: 'Nombre 2',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: apellido1Controller,
                        decoration: const InputDecoration(
                          hintText: 'Apellido 1',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: apellido2Controller,
                        decoration: const InputDecoration(
                          hintText: 'Apellido 2',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: residenciaController,
                        decoration: const InputDecoration(
                          hintText: 'Residencia',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: clavedeaccesoController,
                        decoration: const InputDecoration(
                          hintText: 'Clave de acceso',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: const Text("Registrar"),
                        onPressed: () async {
                          String cedula = cedulaController.text;
                          String nombre1 = nombre1Controller.text;
                          await addUsuarios(
                            cedula: cedula,
                            nombre1: nombre1,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
