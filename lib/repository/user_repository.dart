import 'package:card_agora_vai/entities/user.dart';
import 'package:card_agora_vai/service/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final DatabaseHelper _database;
  UserRepository(this._database);
  String colId = 'id';
  String userTable = 'userTable';
  String colToken = 'token';
  String colNome = 'nome';
  String colEmail = 'email';
  String colIsLogged = 'isLogged';

  //incluir objeto no banco de dados
  Future<int> insertUser(User user) async {
    Database db = await _database.instanceRecover();
    var result = await db.insert(userTable, user.toMap());

    return result;
  }

  Future<User> buscaUsuario() async {
    Database db = await _database.instanceRecover();

    var result = await db.query(userTable);

    List<User> list =
        result.isNotEmpty ? result.map((e) => User.fromMap(e)).toList() : [];
    print(list);
    if (list.isNotEmpty) {
      return list.last;
    } else {
      var user = User();
      return user;
    }
  }

  //atualiza isLogged

  Future<int> isLogged(User user) async {
    var db = await _database.instanceRecover();

    var result = await db.rawUpdate(
        'update $userTable set $colIsLogged = ${user.isLogged ? 1 : 0} where id = ${user.id};');
    print('RESULT DA FUNCAO ISLOGGED $result');
    return result;
  }

  //Deletar um objeto do banco de dados

  Future<int> deleteUsuario(int id) async {
    var db = await _database.instanceRecover();
    int result = await db.delete(
      userTable,
      where: "$colId = ?",
      whereArgs: [id],
    );

    return result;
  }
}
