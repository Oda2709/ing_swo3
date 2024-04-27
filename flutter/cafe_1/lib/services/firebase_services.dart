import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// Obtener todos los registros
Future<List<Map<String, dynamic>>> getHistorial() async {
  List<Map<String, dynamic>> registro = [];
  CollectionReference collectionReferenceRegistro = db.collection('registro');

  QuerySnapshot queryRegistro = await collectionReferenceRegistro.get();

  queryRegistro.docs.forEach((documento) {
    registro.add(documento.data() as Map<String, dynamic>);
  });

  return registro;
}

// Crear usuario en la BD
Future<void> addUsuarios({
  required String cedula,
  required String nombre1,
  required String nombre2,
  required String apellido1,
  required String apellido2,
  required String residencia,
  required String claveAcceso,
}) async {
  await db.collection("registro").doc(cedula).set({
    "cedula": cedula,
    "nombre1": nombre1,
    "nombre2": nombre2,
    "apellido1": apellido1,
    "apellido2": apellido2,
    "residencia": residencia,
    "claveAcceso": claveAcceso,
  });
}

// Verificar si la cédula ya está registrada en Firestore -- no funciona
Future<bool> verificarCedulaExistente(String cedula) async {
  QuerySnapshot query =
      await db.collection("registro").where("cedula", isEqualTo: cedula).get();

  return query.docs.isNotEmpty;
}

//actualizar usuario
Future<void> actualizarusuarios(
  String cedula,
  String newnombre1,
  String newnombre2,
  String newapellido1,
  String newapellido2,
  String newresidencia,
  String newclaveAcceso,
) async {
  await db.collection("registro").doc(cedula).set({
    "cedula": cedula,
    "nombre1": newnombre1,
    "nombre2": newnombre2,
    "apellido1": newapellido1,
    "apellido2": newapellido2,
    "residencia": newresidencia,
    "claveAcceso": newclaveAcceso,
  });
}
