import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; //Sigleton Database Helper
  static Database _database;

  //usada para definir as colunas da tabela
  String colId = 'id';
  String userTable = 'userTable';
  String colToken = 'token';
  String colNome = 'nome';
  String colEmail = 'email';
  String colIsLogged = 'isLogged';

  //construtor nomeado para criar instância da classe
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      //executando somente uma vez
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> instanceRecover() async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> recuperarInstancia() async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'logged_user.db';

    var todoListDataBase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDataBase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colToken TEXT, $colEmail TEXT, $colNome TEXT, $colIsLogged INTEGER NOT NULL);');
  }
}
