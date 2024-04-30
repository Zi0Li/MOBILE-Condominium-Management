import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tcc/data/models/Login.dart';

const String loginTable = 'loginTable';
const String idColumn = 'id';
const String emailColumn = 'email';
const String passwordColumn = 'password';
const String rememberColumn = 'remember';

class LoginController {
  static final LoginController _instance = LoginController.internal();

  factory LoginController() => _instance;

  LoginController.internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'login.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int neweVersion) async {
      await db
          .execute("CREATE TABLE $loginTable($idColumn INTERGER PRIMARY KEY, $emailColumn TEXT, $passwordColumn TEXT, $rememberColumn INTERGER)");
    });
  }

  Future<Login> saveLogin(Login login) async {
    Database dbLogin = await db;
    login.id = await dbLogin.insert(loginTable, login.toMap());

    return login;
  }

  Future<Login?> getLogin(int id) async {
    Database dbLogin = await db;
    List<Map> maps = await dbLogin.query(loginTable,
        columns: [idColumn, emailColumn, passwordColumn, rememberColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Login.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List> getAllLogins() async {
    Database dbLogin = await db;
    List listMap = await dbLogin.rawQuery("SELECT * FROM $loginTable");
    List<Login> listLogin = [];
    for (Map m in listMap) {
      listLogin.add(Login.fromMap(m));
    }
    return listLogin;
  }

  Future<int> deleteLogin(int id) async {
    Database dbLogin = await db;
    return await dbLogin
        .delete(loginTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateLogin(Login login) async {
    Database dbLogin = await db;
    return await dbLogin.update(loginTable, login.toMap(),
        where: "$idColumn=?", whereArgs: [login.id]);
  }

  Future close() async {
    Database dbLogin = await db;
    dbLogin.close();
  }

  Future deletaAll() async {
    Database dbLogin = await db;
    dbLogin.execute("DELETE FROM $loginTable");
  }
}