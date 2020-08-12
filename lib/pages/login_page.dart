import 'package:card_agora_vai/entities/user.dart';
import 'package:card_agora_vai/pages/home_page.dart';
import 'package:card_agora_vai/repository/user_repository.dart';
import 'package:card_agora_vai/service/db_helper.dart';
import 'package:card_agora_vai/service/network_help.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static final routename = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _nomeController.text = 'growdev@growdev.com';
    _senhaController.text = 'growdev@2020';
  }

  final repository = UserRepository(DatabaseHelper());
//TODO: Iniciar o banco e tentar recuperar usuario.
// Se existir, testa o token, se o token for valido, loga usuario logou==true

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _nomeController = TextEditingController();
  var _senhaController = TextEditingController();
  NetworkHelper network = NetworkHelper();
  String userToken;

  void login(String email, String senha) async {
    var logou = await network.login(email, senha);
    if (logou) {
      User user = User(email: email, token: NetworkHelper.token);
      await repository.insertUser(user);
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Logado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      await Future.delayed(Duration(seconds: 3));
      Navigator.popAndPushNamed(context, HomePage.routename);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Login inválido'),
          backgroundColor: Colors.red,
        ),
      );
      //TODO: Programa quebra quando ocorre erro de login
    }
  }
  //growdev@growdev.com
//growdev@2020

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        controller: _nomeController,
                      ),
                      Divider(),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Senha',
                        ),
                        controller: _senhaController,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: () =>
                          login(_nomeController.text, _senhaController.text),
                      child: Text(
                        'Login',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
