import 'package:card_agora_vai/pages/novo_user.dart';
import 'package:card_agora_vai/repository/list_repository.dart';
import 'package:card_agora_vai/repository/user_repository.dart';
import 'package:card_agora_vai/service/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'controllers/user_controller.dart';
import 'entities/user.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/cadastro_edicacao.dart';
import 'service/network_help.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final repository = UserRepository(DatabaseHelper());
  UserController controllerState = UserController();
  User loggedUser = User();

  @override
  void initState() {
    super.initState();
    recuperarUsuario();
  }

  void recuperarUsuario() async {
    repository.buscaUsuario().then((value) {
      loggedUser = value;
      controllerState.setIsLogged(loggedUser.isLogged);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<User>(create: (_) => User()),
        Provider<ListRepository>(create: (_) => ListRepository()),
        Provider<NetworkHelper>(create: (_) => NetworkHelper()),
      ],
      child: Observer(builder: (_) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark(),
          home: controllerState.isLogged ? HomePage() : LoginPage(),
          routes: {
            HomePage.routename: (context) => HomePage(),
            LoginPage.routename: (context) => LoginPage(),
            Cadastro.routename: (context) => Cadastro(),
            NewUser.routeName: (context) => NewUser(),
          },
        );
      }),
    );
  }
}
