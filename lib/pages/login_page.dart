import 'package:card_agora_vai/entities/user.dart';
import 'package:card_agora_vai/pages/home_page.dart';
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

  void login(String email, String senha, User user) async {
    var loggedUser = await network.login(email, senha, context);
    if (loggedUser != null) {
      // User user = User(email: email, token: NetworkHelper.token);

      user.email = loggedUser['user']['email'];
      user.token = loggedUser['token'];
      user.nome = loggedUser['user']['name'];
      user.isLogged = true;

      print('TOKEN ===> ${user.token}');
      print('IS LOGGED ANTES DO BANCO ====> ${user.isLogged}');
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
    final user = Provider.of<User>(context);
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
                      onPressed: () => login(
                          _nomeController.text, _senhaController.text, user),
                      child: Text(
                        'Login',
                      ),
                    ),
                  ),
                  Checkbox(
                      value: user.isLogged ?? false,
                      onChanged: (value) {
                        setState(() {
                          user.isLogged = value;
                          print(user.isLogged);
                        });
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
