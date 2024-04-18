import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '127.0.1.1',
      user = 'root',
      password = '1234',
      db = 'bd_ch2o';

  static int port = 3386;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }

  static query(String s, List<dynamic> list) {}
}
