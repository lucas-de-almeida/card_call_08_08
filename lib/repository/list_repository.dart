import 'dart:convert';

import 'package:card_agora_vai/entities/cards.dart';
import 'package:card_agora_vai/service/network_help.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ListRepository {
  final networkHelper = NetworkHelper();

  Future<List<Cards>> buscaLista() async {
    Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://api-cards-growdev.herokuapp.com',
          headers: {"Authorization": "Token ${networkHelper.tokenGetter()};"}),
    );

    var resposta = await dio.get('/cards');

    List<dynamic> listaCards = resposta.data;
    var retorno = listaCards.map<Cards>((e) => Cards.fromJson(e)).toList();

    return retorno;
  }

  Future deletaCard(int id) async {
    var dio = Dio(BaseOptions(
        baseUrl: 'https://api-cards-growdev.herokuapp.com',
        headers: {"Authorization": "Token $networkHelper.tokenGetter()"}));
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
        headers: {"Authorization": "Token $networkHelper.tokenGetter()"}));
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
        headers: {"Authorization": "Token $networkHelper.tokenGetter()"}));
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
