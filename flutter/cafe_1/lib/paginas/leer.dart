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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, '/buscar'); // Navegar a la página de búsqueda
            },
            icon: Icon(Icons.search), // Icono de búsqueda
          ),
        ],
      ),
      body: FutureBuilder(
          future: getHistorial(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final historial = snapshot.data as List<Map<String, dynamic>>?;

            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  //Delete
                  return Dismissible(
                    //elimina de la BD
                    onDismissed: (direction) async {
                      await eliminarUsuario(item['cedula']);
                    },

                    confirmDismiss: (direction) async {
                      bool result = false;
                      // dialogo
                      result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                "¿Está seguro de eliminar el registro ${item['cedula']}?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    return Navigator.pop(
                                      context,
                                      false,
                                    );
                                  },
                                  child: const Text(
                                    "Cancelar",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    return Navigator.pop(
                                      context,
                                      true,
                                    );
                                  },
                                  child: const Text("Si, Estoy seguro"))
                            ],
                          );
                        },
                      );

                      return result;
                    },
                    background: Container(
                      width: 630,
                      color: Colors.red,
                      child: const Icon(Icons.delete),
                    ),
                    direction: DismissDirection.endToStart,
                    key: ValueKey(item['cedula']),

                    //leer
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
                            Text('Clave de acceso: ${item['claveAcceso']}'),
                            const SizedBox(width: 10),
                            Text('Correo electronico: ${item['correo']}'),
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
                                    'correo': item['correo'],
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
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          })),
    );
  }
}
