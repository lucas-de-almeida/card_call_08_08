import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/cadastro_edicacao.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        HomePage.routename: (context) => HomePage(),
        LoginPage.routename: (context) => LoginPage(),
        Cadastro.routename: (context) => Cadastro(),
      },
    );
  }
}
