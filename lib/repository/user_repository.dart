import 'package:card_agora_vai/entities/user.dart';
import 'package:card_agora_vai/service/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final DatabaseHelper _database;
  UserRepository(this._database);
  String colId = 'id';
  String userTable = 'userTable';
  String colToken = 'token';
  String colEmail = 'email';

  //incluir objeto no banco de dados
  Future<int> insertUser(User task) async {
    Database db = await _database.instanceRecover();
    var result = await db.insert(userTable, task.toMap());

    return result;
  }

  Future<List<User>> buscaUsuarios() async {
    Database db = await _database.instanceRecover();

    var result = await db.query(userTable);

    List<User> list =
        result.isNotEmpty ? result.map((e) => User.fromMap(e)).toList() : [];

    return list;
  }

  /* //atualiza isLogged

  Future<int> isLogged(User user) async {
    var db = await _database.instanceRecover();
    print(user.done);
    var result = await db.rawUpdate(
        'update $todoTable set done = ${user.done ? 1 : 0} where id = ${user.id};');
    return result;
  } */

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
