import 'package:cafe_1/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:cafe_1/services/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';

class Eliminar extends StatefulWidget {
  const Eliminar({
    super.key,
  });

  @override
  State<Eliminar> createState() => _EliminarState();
}

class _EliminarState extends State<Eliminar> {
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
                  return Dismissible(
                    key: Key(item['cedula']),
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.account_balance_wallet),
                        title: Text(
                            'Usuario: ${item['nombre1']} ${item['nombre2']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cedula: ${item['cedula']}'),
                            const SizedBox(width: 10),
                            Text('Primer Nombre: ${item['nombre1']}'),
                            const SizedBox(width: 10),
                            Text('Segundo Nombre: ${item['nombre2']}'),
                            const SizedBox(width: 10),
                            Text('Primer Apellido: ${item['apellido1']}'),
                            const SizedBox(width: 10),
                            Text('Segundo Apellido: ${item['apellido2']}'),
                            const SizedBox(width: 10),
                            Text('Ciudad: ${item['residencia']}'),
                            const SizedBox(width: 10),
                            Text('clave de acceso: ${item['claveAcceso']}'),
                            const SizedBox(width: 10),
                            //consultar si seagrega la clave
                          ],
                        ),
                        //botonpara editar los datos
                        trailing: SizedBox(
                          width: 30,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/actualizar',
                                  arguments: {
                                    'cedula': item['cedula'],
                                    'nombre1': item['nombre1'],
                                    'nombre2': item['nombre2'],
                                    'apellido1': item['apellido1'],
                                    'apellido2': item['apellido2'],
                                    'residencia': item['residencia'],
                                    'claveAcceso': item['claveAcceso'],
                                  });
                            },
                            child: const Icon(Icons.edit),
                          ),
                        ),
                      ),
                    ),
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
