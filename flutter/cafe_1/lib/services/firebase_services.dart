import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

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
  required String correo,
}) async {
  await db.collection("registro").doc(cedula).set({
    "cedula": cedula,
    "nombre1": nombre1,
    "nombre2": nombre2,
    "apellido1": apellido1,
    "apellido2": apellido2,
    "residencia": residencia,
    "claveAcceso": claveAcceso,
    "correo": correo,
  });
}

// Verificar si la cédula ya está registrada en Firestore
Future<bool> verificarCedulaExistente(String cedula) async {
  QuerySnapshot query =
      await db.collection("registro").where("cedula", isEqualTo: cedula).get();

  return query.docs.isNotEmpty;
}

// Verificar si el correo ya está registrada en Firestore
Future<bool> verificarCorreoExistente(String correo) async {
  QuerySnapshot query =
      await db.collection("registro").where("correo", isEqualTo: correo).get();

  return query.docs.isNotEmpty;
}

//Actualizar usuario
Future<void> actualizarusuarios(
  String cedula,
  String newnombre1,
  String newnombre2,
  String newapellido1,
  String newapellido2,
  String newresidencia,
  String newclaveAcceso,
  String correo,
) async {
  await db.collection("registro").doc(cedula).set({
    "cedula": cedula,
    "nombre1": newnombre1,
    "nombre2": newnombre2,
    "apellido1": newapellido1,
    "apellido2": newapellido2,
    "residencia": newresidencia,
    "claveAcceso": newclaveAcceso,
    "correo": correo,
  });
}

//Eliminar de la BD
//Future<void> eliminarusuarios(String cedula) async {
//await db.collection("registro").doc(cedula).delete();
//}
Future<void> eliminarUsuario(String cedula) async {
  try {
    print('Eliminando usuario con cédula: $cedula');

    // Obtener la referencia al documento del usuario
    final userRef =
        FirebaseFirestore.instance.collection('registro').doc(cedula);

    print('Referencia del usuario: $userRef');

    // Verificar si el documento existe
    final docSnapshot = await userRef.get();
    if (!docSnapshot.exists) {
      print('El usuario con cédula $cedula no existe en la base de datos.');
      return;
    }

    // Eliminar el documento
    await userRef.delete();

    print('Usuario eliminado exitosamente.');
  } catch (e) {
    // Manejar errores
    print('Error al eliminar usuario: $e');
    throw Exception('Error al eliminar usuario');
  }
}

//Buscar
Future<Map<String, dynamic>?> buscarPorCedula(String cedula) async {
  try {
    DocumentSnapshot documentSnapshot =
        await db.collection('registro').doc(cedula).get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  } catch (error) {
    print('Error al buscar por cédula: $error');
    return null;
  }
}

// Registro con correo y contraseña
Future<void> registrarUsuario({
  required String correo,
  required String claveAcceso,
}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: correo, password: claveAcceso);

    // Luego de registrar el usuario en Firebase Authentication, puedes guardar información adicional en Firestore
    await db.collection("registro").doc(userCredential.user!.uid).set({
      "correo": correo,
      "claveAcceso": claveAcceso,
    });
  } catch (error) {
    print('Error al registrar usuario: $error');
    throw error; // Puedes manejar este error en la interfaz de usuario
  }
}

// Inicio de sesión con correo y contraseña
Future<void> iniciarSesion({
  required String correo,
  required String claveAcceso,
}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: correo, password: claveAcceso);
  } catch (error) {
    print('Error al iniciar sesión: $error');
    throw error; // Puedes manejar este error en la interfaz de usuario
  }
}

// Cierre de sesión
Future<void> cerrarSesion() async {
  await FirebaseAuth.instance.signOut();
}

// Verificar si el usuario está autenticado
bool estaAutenticado() {
  return FirebaseAuth.instance.currentUser != null;
}
