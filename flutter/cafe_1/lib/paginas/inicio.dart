import 'dart:async';
import 'dart:convert';
import 'package:cafe_1/firebase_options.dart';
import 'package:cafe_1/paginas/leer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cafe_1/paginas/menu.dart';
import 'package:cafe_1/paginas/registro.dart';
import 'package:flutter/material.dart';

//editado para firebase Future

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              SizedBox(height: 50.0),
              Center(
                child: Image.asset(
                  'assets/Logo.png',
                  height: 150.0,
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Cédula',
                  hintText: 'Ingrese su número de cédula',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Ingrese su contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.teal[700],
                ),
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
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
