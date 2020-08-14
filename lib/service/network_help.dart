import 'dart:convert';

import 'package:card_agora_vai/entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../entities/cards.dart';
import 'package:dio/dio.dart';

class NetworkHelper {
  static String _token;
  var context;

  setContext(BuildContext newContext) => context = newContext;

  //final user = Provider.of<User>(interContext);

  tokenGetter() => _token;
  tokkenSetter(String token) => _token = token;

  Future login(String email, String password, BuildContext context) async {
    print('entrou funcao');
    var dio =
        Dio(BaseOptions(baseUrl: 'https://api-cards-growdev.herokuapp.com'));
    var dados = {"email": "$email", "password": "$password"};

    var resposta = await dio.post('/login', data: dados);
    print(resposta.data['user']['name']);

    if (resposta.statusCode >= 200 && resposta.statusCode < 300) {
      print(resposta.data);
      _token = resposta.data['token'];
      //TODO: Este token tem que ser acessível em todo o projeto.
      return resposta.data;
    } else {
      print(resposta.statusMessage);
      return null;
    }
  }

  Future<List<Cards>> buscaLista() async {
    if (_token == null) {
      return [];
    }

    Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://api-cards-growdev.herokuapp.com',
          headers: {"Authorization": "Token $_token"}),
    );

    var resposta = await dio.get('/cards');

    List<dynamic> listaCards = resposta.data;
    var retorno = listaCards.map<Cards>((e) => Cards.fromJson(e)).toList();

    return retorno;
  }

  /* Future<List<Cards>> buscaListaLogged(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://api-cards-growdev.herokuapp.com',
          headers: {"Authorization": "Token ${_token}"}),
    );

    var resposta = await dio.get('/cards');

    List<dynamic> listaCards = resposta.data;
    var retorno = listaCards.map<Cards>((e) => Cards.fromJson(e)).toList();

    return retorno;
  } */

  Future deletaCard(int id) async {
    var dio = Dio(BaseOptions(
        baseUrl: 'https://api-cards-growdev.herokuapp.com',
        headers: {"Authorization": "Token $_token"}));
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
        headers: {"Authorization": "Token $_token"}));
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
        headers: {"Authorization": "Token $_token"}));
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
