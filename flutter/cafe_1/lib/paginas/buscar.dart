import 'package:flutter/material.dart';
import 'package:cafe_1/services/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';

class Buscar extends StatefulWidget {
  const Buscar({
    Key? key,
  });

  @override
  State<Buscar> createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  TextEditingController cedulaController = TextEditingController();

  bool _showResults = false;
  Map<String, dynamic>? _searchResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cedulaController,
              decoration: const InputDecoration(
                hintText: 'Buscar por Cédula',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              String cedula = cedulaController.text;
              Map<String, dynamic>? result = await buscarPorCedula(cedula);
              setState(() {
                _searchResult = result;
                _showResults = true;
              });
            },
            child: const Text('Buscar'),
          ),
          if (_showResults)
            _searchResult != null
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                  'Usuario: ${_searchResult!['nombre1']} ${_searchResult!['nombre2']}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Cédula: ${_searchResult!['cedula']}'),
                                  Text(
                                      'Primer Nombre: ${_searchResult!['nombre1']}'),
                                  Text(
                                      'Segundo Nombre: ${_searchResult!['nombre2']}'),
                                  Text(
                                      'Primer Apellido: ${_searchResult!['apellido1']}'),
                                  Text(
                                      'Segundo Apellido: ${_searchResult!['apellido2']}'),
                                  Text(
                                      'Ciudad: ${_searchResult!['residencia']}'),
                                  Text(
                                      'Clave de acceso: ${_searchResult!['claveAcceso']}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Text('No se encontraron resultados'),
        ],
      ),
    );
  }
}
