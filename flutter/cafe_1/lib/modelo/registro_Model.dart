class User {
  final double cedula;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String residencia;
  final String claveacceso;
  final String correo;
  final bool confirmado;

  User(
      {required this.cedula,
      required this.nombre1,
      required this.nombre2,
      required this.apellido1,
      required this.apellido2,
      required this.residencia,
      required this.claveacceso,
      required this.correo,
      required this.confirmado});

  User.empty({
    this.cedula = 0.0,
    this.nombre1 = " ",
    this.nombre2 = " ",
    this.apellido1 = " ",
    this.apellido2 = " ",
    this.residencia = " ",
    this.claveacceso = " ",
    this.correo = " ",
    this.confirmado = false,
  });

  /*User();

  double getCedula() {
    return cedula;
  }

  String getNombre1() {
    return nombre1;
  }

  String getNombre2() {
    return nombre2;
  }

  String getApellido1() {
    return apellido1;
  }

  String getApellido2() {
    return apellido2;
  }

  String getResidencia() {
    return residencia;
  }

  String getClavedeacceso() {
    return clavedeacceso;
  }*/
}
