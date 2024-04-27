import 'dart:async';
import 'package:cafe_1/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe_1/modelo/registro_Model.dart';
import 'package:flutter/services.dart';

class Actualizar extends StatefulWidget {
  const Actualizar({
    super.key,
  });

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombre1Controller = TextEditingController();
  final TextEditingController nombre2Controller = TextEditingController();
  final TextEditingController apellido1Controller = TextEditingController();
  final TextEditingController apellido2Controller = TextEditingController();
  final TextEditingController residenciaController = TextEditingController();
  final TextEditingController claveAccesoController = TextEditingController();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      cedulaController.text = arguments['cedula'] ?? '';
      nombre1Controller.text = arguments['nombre1'] ?? '';
      nombre2Controller.text = arguments['nombre2'] ?? '';
      apellido1Controller.text = arguments['apellido1'] ?? '';
      apellido2Controller.text = arguments['apellido2'] ?? '';
      residenciaController.text = arguments['residencia'] ?? '';
      claveAccesoController.text = arguments['claveAcceso'] ?? '';
    }

    print(arguments);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualización de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
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
                        //no permite que la cedula sea editada
                        readOnly: true,
                        decoration: const InputDecoration(
                          prefixText:
                              'La cedula no puede ser editada -> su cedula es: ',
                          hintText: 'Cédula',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nombre1Controller,
                        decoration: const InputDecoration(
                          hintText: 'Actualizar Primer Nombre',
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]')),
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nombre2Controller,
                        decoration: const InputDecoration(
                          hintText: 'Actualizar Segundo Nombre',
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]')),
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: apellido1Controller,
                        decoration: const InputDecoration(
                          hintText: 'Actualizar Primer Apellido',
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]')),
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: apellido2Controller,
                        decoration: const InputDecoration(
                          hintText: 'Actualizar Segundo Apellido',
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]')),
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: residenciaController,
                        decoration: const InputDecoration(
                          hintText: 'Actualizar Ciudad',
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]')),
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: claveAccesoController,
                        //no permite que la clave sea editada
                        readOnly: true,
                        decoration: const InputDecoration(
                          prefixText:
                              'La clave no puede ser editada -> su clave es: ',
                          hintText: 'claveacceso',
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          child: const Text("Actualizar"),
                          onPressed: () async {
                            String nombre1 = nombre1Controller.text;
                            String nombre2 = nombre2Controller.text;
                            String apellido1 = apellido1Controller.text;
                            String apellido2 = apellido2Controller.text;
                            String residencia = residenciaController.text;

                            if (nombre1.isEmpty ||
                                nombre2.isEmpty ||
                                apellido1.isEmpty ||
                                apellido2.isEmpty ||
                                residencia.isEmpty) {
                              setState(() {
                                _errorMessage =
                                    "Dejo datos en blanco favor verificar antes de actualizar";
                              });
                              return;
                            }

                            try {
                              // Actualizar el usuario solo si la cédula no está registrada
                              await actualizarusuarios(
                                arguments?['cedula'],
                                nombre1Controller.text,
                                nombre2Controller.text,
                                apellido1Controller.text,
                                apellido2Controller.text,
                                residenciaController.text,
                                claveAccesoController.text,
                              );

                              // Mostrar mensaje de éxito
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Actualización exitosa"),
                                    content: const Text(
                                        "El usuario ha sido actualizado correctamente."),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Aceptar"),
                                        onPressed: () async {
                                          await Navigator.pushNamed(
                                              context, '/');
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );

                              print("Registro exitoso");
                            } catch (e) {
                              // Manejo de errores
                              if (e is FirebaseAuthException) {
                                print('Error desconocido: ${e.message}');
                              } else {
                                print('Error no relacionado con Firebase: ');
                                // Mostrar mensaje de error genérico al usuario
                              }
                            }
                          }),
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
