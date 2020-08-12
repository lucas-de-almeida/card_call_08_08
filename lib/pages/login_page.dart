import 'package:card_agora_vai/pages/home_page.dart';
import 'package:card_agora_vai/service/network_help.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static final routename = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _nomeController = TextEditingController();
  var _senhaController = TextEditingController();
  NetworkHelper network = NetworkHelper();
  String userToken;

  void login(String email, String senha) async {
    var logou = await NetworkHelper.login(email, senha);
    if (logou) {
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
