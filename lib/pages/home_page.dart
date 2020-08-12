import 'package:card_agora_vai/login/login_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'cadastro_edicacao.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  static final routename = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listaService = LoginService();
  @override
  void initState() {
    listaService.buscaLista();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(Cadastro.routename),
          ),
        ],
        title: Text('Home Page'),
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: Colors.blueGrey,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Buscar Lista'),
              trailing: Icon(Icons.list),
              onTap: () async => LoginService().buscaLista(),
            ),
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              accountEmail: Text('email'),
              accountName: Text('nome'),
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
              onTap: () =>
                  Navigator.of(context).popAndPushNamed(LoginPage.routename),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(builder: (_) {
          return ListView.builder(
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
          );
        }),
      ),
    );
  }
}
