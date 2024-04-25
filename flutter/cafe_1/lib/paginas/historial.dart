import 'package:cafe_1/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:cafe_1/services/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';

class Pagina extends StatefulWidget {
  const Pagina({
    super.key,
  });

  @override
  State<Pagina> createState() => _PaginaState();
}

class _PaginaState extends State<Pagina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      body: FutureBuilder(
          future: getHistorial(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return Row(
                    // Or another layout widget as needed
                    children: [
                      Text('cedula: ${item['cedula']}'),
                      const SizedBox(width: 10),
                      Text('nombre1: ${item['nombre1']}'),
                      const SizedBox(width: 10),
                      Text('nombre2: ${item['nombre2']}'),
                      const SizedBox(width: 10),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}')); // Handle errors
            }

            return const Center(child: CircularProgressIndicator());
          })),
    );
  }
}
