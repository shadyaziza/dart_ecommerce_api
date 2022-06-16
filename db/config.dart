import 'package:postgres/postgres.dart';

class DatabaseConfig {
  DatabaseConfig._() {
    init();
  }
  static DatabaseConfig? _instance;
  // ignore: prefer_constructors_over_static_methods
  static DatabaseConfig get instance => _instance ??= DatabaseConfig._();
  late final PostgreSQLConnection connection;
  Future<void> init() async {
    connection = PostgreSQLConnection(
      'localhost',
      5432,
      'ecommerce',
      username: 'postgressss',
      password: 'admin',
    );
    await connection.open();
  }
}
