import 'dart:async';
import 'dart:convert';
import 'package:cafe_1/firebase_options.dart';
import 'package:cafe_1/paginas/leer.dart';
import 'package:cafe_1/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cafe_1/paginas/menu.dart';
import 'package:cafe_1/paginas/registro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//editado para firebase Future

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController correoController = TextEditingController();
  TextEditingController claveAccesoController = TextEditingController();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: Center(
          child: Text(
            'C_H2O Cafe',
            style: TextStyle(
              color: const Color.fromARGB(255, 193, 117, 117),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 50.0),
              Center(
                child: Image.asset(
                  'assets/Logo.png',
                  height: 150.0,
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: correoController,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    hintText: 'Ingrese su correo electronico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    //FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(30),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: claveAccesoController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Ingrese su contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text("Iniciar Sesión"),
                  onPressed: () async {
                    String correo = correoController.text;
                    String claveAcceso = claveAccesoController.text;

                    if (correo.isEmpty || claveAcceso.isEmpty) {
                      setState(() {
                        _errorMessage = "Todos los campos son obligatorios";
                      });
                      return;
                    }

                    // Llama a la función de inicio de sesión
                    try {
                      await iniciarSesion(
                          correo: correo, claveAcceso: claveAcceso);
                    } catch (error) {
                      setState(() {
                        _errorMessage = "Error al iniciar sesión: $error";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/registro');
                  setState(() {});
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: const Color.fromARGB(255, 39, 11, 11)),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/leer');
                  setState(() {});
                },
                child: Text(
                  'Listar usuarios',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: const Color.fromARGB(255, 39, 11, 11)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
