import 'dart:convert';

import 'package:card_agora_vai/login/login_service.dart';

import '../entities/cards.dart';
import 'package:dio/dio.dart';

class NetworkHelper {
  static String token;
  Future<bool> login(String email, String password) async {
    print('entrou funcao');
    var dio =
        Dio(BaseOptions(baseUrl: 'https://api-cards-growdev.herokuapp.com'));
    var dados = {"email": "$email", "password": "$password"};

    var resposta = await dio.post('/login', data: dados);
    print(resposta.data);

    if (resposta.statusCode >= 200 && resposta.statusCode < 300) {
      token = resposta.data['token'];
      print(resposta.data);
      //TODO: Este token tem que ser acessível em todo o projeto.
      return true;
    } else {
      print(resposta.statusMessage);
      return false;
    }
  }

  Future<List<Cards>> buscaLista() async {
    Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://api-cards-growdev.herokuapp.com',
          headers: {"Authorization": "Token $token"}),
    );

    var resposta = await dio.get('/cards');

    List<dynamic> listaCards = resposta.data;
    var retorno = listaCards.map<Cards>((e) => Cards.fromJson(e)).toList();

    return retorno;
  }

  Future deletaCard(int id) async {
    var dio = Dio(BaseOptions(
        baseUrl: 'https://api-cards-growdev.herokuapp.com',
        headers: {"Authorization": "Token $token"}));
    var resposta = await dio.delete('/cards/$id');
    if (resposta.statusCode >= 300 && resposta.statusCode < 200) {
      print(resposta.statusMessage);
    } else {
      print('Card deletado!');
    }
  }

  Future<void> salvarCard(Cards post) async {
    var dio = Dio(BaseOptions(
        baseUrl: 'https://api-cards-growdev.herokuapp.com',
        headers: {"Authorization": "Token $token"}));
    var dados = jsonEncode(post.toJson());
    var resposta = await dio.post('/cards', data: dados);

    if (resposta.statusCode >= 200 && resposta.statusCode < 300) {
    } else {
      print(resposta.statusMessage);
    }
  }

  Future<void> editarCard(Cards post) async {
    var dio = Dio(BaseOptions(
        baseUrl: 'https://api-cards-growdev.herokuapp.com',
        headers: {"Authorization": "Token $token"}));
    var dados = jsonEncode(post.toJson());
    var resposta = await dio.put('/cards/${post.id}', data: dados);
    Cards retorno;
    if (resposta.statusCode >= 200 && resposta.statusCode < 300) {
      retorno = Cards.fromJson(resposta.data);
    } else {
      print(resposta.statusMessage);
    }
    return retorno;
  }
}
