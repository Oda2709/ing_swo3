import 'package:cafe_1/paginas/menu.dart';
import 'package:cafe_1/paginas/registro.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Assuming you have an Image widget named 'myImage' defined elsewhere
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'C_H2O Cafe',
      home: LoginPage(), // Replace with your login page widget
      theme: ThemeData(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _cedula = '';
  String _contrasena = '';

  static const String host = '127.0.1.1';
  static const int port = 3306;
  static const String user = 'root';
  static const String password = ' ';
  static const String db = 'bd_ch2o';

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }

  Future<bool> validateLogin() async {
    var conn = await getConnection();
    try {
      var query = '''
        SELECT * FROM usuario WHERE idcedula = ? AND contrasena = ?
      ''';
      var results = await conn.query(query, [_cedula, _contrasena]);
      return results.isNotEmpty;
    } finally {
      await conn.close();
    }
  }

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
          key: _formKey,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su cédula';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _cedula = value!),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _contrasena = value!),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var push = Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.teal[700],
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  var push = Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registro()),
                  );
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  var push = Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registro()),
                  );
                },
                child: Text(
                  'Recuperar Contraseña',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
