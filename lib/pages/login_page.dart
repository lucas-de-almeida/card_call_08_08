import 'dart:ui';

import 'package:card_agora_vai/entities/user.dart';
import 'package:card_agora_vai/pages/home_page.dart';
import 'package:card_agora_vai/pages/novo_user.dart';
import 'package:card_agora_vai/repository/user_repository.dart';
import 'package:card_agora_vai/service/db_helper.dart';
import 'package:card_agora_vai/service/network_help.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final routename = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _password;
  @override
  void initState() {
    super.initState();
    _nomeController.text = 'growdev@growdev.com';
    _senhaController.text = 'growdev@2020';
    _password = true;
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

  void login(String email, String senha, User user) async {
    var loggedUser = await network.login(email, senha, context);
    if (loggedUser != null) {
      user.email = loggedUser['user']['email'];
      user.token = loggedUser['token'];
      user.nome = loggedUser['user']['name'];

      if (user.isLogged) {
        await repository.buscaUsuarioUnico(user).then((value) async {
          if (!value) {
            print('INSERINDO USUARIO NO BANCO');
            await repository.insertUser(user);
          }
        });
      }

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
    final user = Provider.of<User>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/dois.jpg'),
            fit: BoxFit.cover,
          ),
          /* gradient: LinearGradient(
            colors: [Color(0xff293568), Color(0xff1B1A2A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ), */
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'E-Mail',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                              ),
                              // labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            controller: _nomeController,
                          ),
                        ),
                        Text(
                          'Password',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              // labelText: 'Senha',
                              labelStyle: TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                icon: Icon(_password
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _password = !_password;
                                  });
                                },
                              ),
                            ),
                            obscureText: _password,
                            controller: _senhaController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [Colors.purple[900], Colors.teal[800]],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                      child: FlatButton(
                        onPressed: () => login(
                            _nomeController.text, _senhaController.text, user),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                        value: user.isLogged ?? false,
                        onChanged: (value) async {
                          setState(() {
                            user.isLogged = value;
                            print(user.isLogged);
                          });
                        }),
                    Text('Manter logado'),
                  ],
                ),
                FlatButton(
                    onPressed: () async {
                      var newUser = await Navigator.of(context)
                          .pushNamed(NewUser.routeName);
                    },
                    child: Text('Sign'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
