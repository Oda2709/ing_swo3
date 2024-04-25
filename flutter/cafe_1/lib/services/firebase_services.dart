import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//se ven todo los registros
Future<List> getHistorial() async {
  List registro = [];
  CollectionReference collectionReferenceRegistro = db.collection('registro');

  QuerySnapshot queryRegistro = await collectionReferenceRegistro.get();
  queryRegistro.docs.forEach((documento) {
    registro.add(documento.data());
  });

  return registro;
}

//crear usuario en la BD
Future<void> addUsuarios(
    {required String cedula, required String nombre1}) async {
  await db.collection("registro").add({
    "cedula": cedula,
    "nombre1": nombre1,
  });
}
