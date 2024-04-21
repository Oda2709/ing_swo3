import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//se ven todo los registros
Future<List> getRegistro() async {
  List registro = [];
  CollectionReference collectionReferenceRegistro = db.collection('registro');

  QuerySnapshot queryRegistro = await collectionReferenceRegistro.get();
  queryRegistro.docs.forEach((documento) {
    registro.add(documento.data());
  });

  return registro;
}
