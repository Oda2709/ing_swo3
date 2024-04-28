import 'dart:async';
import 'package:cafe_1/services/firebase_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe_1/modelo/registro_Model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Registro extends StatefulWidget {
  const Registro({
    super.key,
  });

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  TextEditingController cedulaController = TextEditingController();
  TextEditingController nombre1Controller = TextEditingController();
  TextEditingController nombre2Controller = TextEditingController();
  TextEditingController apellido1Controller = TextEditingController();
  TextEditingController apellido2Controller = TextEditingController();
  TextEditingController residenciaController = TextEditingController();
  TextEditingController clavedeaccesoController = TextEditingController();
  TextEditingController correoController = TextEditingController();

  String? _errorMessage;

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
                        decoration: const InputDecoration(
                          hintText: 'Cédula (sin puntos)',
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
                          hintText: 'Primer Nombre',
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
                          hintText: 'Segundo Nombre',
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
                          hintText: 'Primer Apellido',
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
                          hintText: 'Segundo Apellido',
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
                          hintText: 'Ciudad',
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
                        controller: correoController,
                        decoration: const InputDecoration(
                          hintText: 'Ingrese correo',
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(30),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: clavedeaccesoController,
                        decoration: const InputDecoration(
                          hintText:
                              'Clave de acceso (Puede ser alfanumerica con minimo 8 y maximo 15)',
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                          child: const Text("Registrar"),
                          onPressed: () async {
                            String cedula = cedulaController.text;
                            String nombre1 = nombre1Controller.text;
                            String nombre2 = nombre2Controller.text;
                            String apellido1 = apellido1Controller.text;
                            String apellido2 = apellido2Controller.text;
                            String residencia = residenciaController.text;
                            String claveAcceso = clavedeaccesoController.text;
                            String correo = correoController.text;

                            if (cedula.isEmpty ||
                                nombre1.isEmpty ||
                                nombre2.isEmpty ||
                                apellido1.isEmpty ||
                                apellido2.isEmpty ||
                                residencia.isEmpty ||
                                claveAcceso.isEmpty ||
                                correo.isEmpty) {
                              setState(() {
                                _errorMessage =
                                    "Todos los campos son obligatorios";
                              });
                              return;
                            }

                            // Verificar si la cédula ya está registrada
                            bool cedulaExiste =
                                await verificarCedulaExistente(cedula);
                            if (cedulaExiste) {
                              setState(() {
                                _errorMessage = "La cédula ya está registrada.";
                              });
                              return;
                            }

                            // Verificar si el correo ya está registrado
                            bool correoExiste =
                                await verificarCorreoExistente(correo);
                            if (correoExiste) {
                              setState(() {
                                _errorMessage = "el correo ya está registrado.";
                              });
                              return;
                            }

                            // Validar el correo electrónico
                            if (!EmailValidator.validate(correo)) {
                              setState(() {
                                _errorMessage =
                                    "Ingrese una dirección de correo electrónico válida.";
                              });
                              return;
                            }

                            if (claveAcceso.length < 8) {
                              setState(() {
                                _errorMessage =
                                    "La clave debe tener como minimo 8 caracteres";
                              });
                              return;
                            }

                            try {
                              // Agregar el usuario solo si la cédula no está registrada
                              await addUsuarios(
                                cedula: cedula,
                                nombre1: nombre1,
                                nombre2: nombre2,
                                apellido1: apellido1,
                                apellido2: apellido2,
                                residencia: residencia,
                                claveAcceso: claveAcceso,
                                correo: correo,
                              );

                              // Mostrar mensaje de éxito
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Registro exitoso"),
                                    content: const Text(
                                        "El usuario ha sido registrado correctamente."),
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
