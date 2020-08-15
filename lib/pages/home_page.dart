import 'package:card_agora_vai/controllers/list_controller.dart';
import 'package:card_agora_vai/entities/user.dart';
import 'package:card_agora_vai/repository/user_repository.dart';
import 'package:card_agora_vai/service/db_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'cadastro_edicacao.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  static final routename = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listaService = ListController();
  final repository = UserRepository(DatabaseHelper());
  @override
  void initState() {
    super.initState();

    listaService.buscaLista();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    if (user.token == null) {
      repository.buscaUsuario().then((value) {
        setState(() {
          user.nome = value.nome;
          user.email = value.email;
          user.token = value.token;
          user.id = value.id;
          print('USER ID ===> ${user.id}');
          listaService.setToken(user.token);
        });
        listaService.buscaLista();
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(Cadastro.routename),
          ),
        ],
        title: Text('Home Page'),
        // backgroundColor: Colors.purple[900],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  colors: [Colors.purple[900], Colors.teal[900]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Buscar Lista'),
                trailing: Icon(Icons.list),
                onTap: () async => ListController().buscaLista(),
              ),
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                accountEmail: Text(user.email ?? ''),
                accountName: Text(user.nome ?? ''),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.gravatar.com/avatar/123?d=robohash'),
                ),
              ),
              // ListTile(
              //   title: Text('Novo Card'),
              //   trailing: Icon(Icons.add),
              //   onTap: () =>
              //       Navigator.of(context).pushNamed(Cadastro.routename),
              // ),
              // ListTile(
              //   title: Text('Atualizar Card'),
              //   trailing: Icon(Icons.update),
              // ),
              // ListTile(
              //   title: Text('Remover Card'),
              //   trailing: Icon(Icons.delete),
              //   onTap: () => showDialog(
              //     context: context,
              //     child: AlertDialog(
              //       title: Text('Insira o id do card a ser excluido'),
              //       actions: <Widget>[],
              //     ),
              //   ),
              // ),
              ListTile(
                  title: Text('Sair'),
                  trailing: Icon(Icons.exit_to_app),
                  onTap: () async {
                    // print('USER ID HORA EXCLUIR ===> ${user.id}');
                    //await repository.deleteUsuario(user.id);
                    user.isLogged = false;
                    await repository.isLogged(user);
                    Navigator.of(context).popAndPushNamed(LoginPage.routename);
                  }),
            ],
          ),
        ),
      ),
      body: Observer(builder: (_) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple[900], Colors.teal[900]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: listaService.listaCards.length ?? 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    listaService.deletaCard(
                      listaService.listaCards[index].id,
                    );
                    listaService.buscaLista();
                  },
                  background: Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.all(10), child: Icon(Icons.delete)),
                    color: Colors.red,
                  ),
                  key: UniqueKey(),
                  child: Card(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: Text(
                          'id: ${listaService.listaCards[index].id.toString()}'),
                      title: Text(
                          listaService.listaCards[index].title ?? 'Sem título'),
                      subtitle: Text(listaService.listaCards[index].content ??
                          'Sem conteúdo'),
                      trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => Navigator.of(context).pushNamed(
                              Cadastro.routename,
                              arguments: listaService.listaCards[index])),
                      isThreeLine: true,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
