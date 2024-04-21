import 'dart:async';
import 'dart:convert';
import 'package:cafe_1/paginas/historial.dart';
import 'package:cafe_1/services/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cafe_1/paginas/menu.dart';
import 'package:cafe_1/paginas/registro.dart';
import 'package:flutter/material.dart';

//editado para firebase Future
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

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
        title: FutureBuilder(
          future: getRegistro(),
          builder: (context, snapshot) {
            return Text(
              'C_H2O Cafe',
              style: TextStyle(
                color: const Color.fromARGB(255, 193, 117, 117),
              ),
            );
          },
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
              SizedBox(height: 10.0),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registro()),
                  );
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: const Color.fromARGB(255, 39, 11, 11)),
                ),
              ),
              SizedBox(height: 10.0),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pagina()),
                  );
                },
                child: Text(
                  'Recuperar Contraseña',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: const Color.fromARGB(255, 31, 9, 9)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
