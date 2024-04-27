import 'dart:async';
import 'dart:convert';
import 'package:cafe_1/paginas/actualizar.dart';
import 'package:cafe_1/paginas/eliminar.dart';
import 'package:cafe_1/paginas/leer.dart';
import 'package:cafe_1/paginas/inicio.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lavado del cafe',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/registro': (context) => const Registro(),
        '/leer': (context) => const Pagina(),
        '/actualizar': (context) => const Actualizar(),
        '/eliminar': (context) => const Eliminar(),
      },
    );
  }
}
