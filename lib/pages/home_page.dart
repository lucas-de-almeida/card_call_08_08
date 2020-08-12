import 'package:card_agora_vai/service/network_help.dart';
import 'package:flutter/material.dart';
import '../entities/cards.dart';
import 'cadastro_edicacao.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  static final routename = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    NetworkHelper.buscaLista().then((value) {
      setState(() {
        lista = value;
      });
    });
  }

  List<Cards> lista = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                onTap: () async => NetworkHelper.buscaLista().then((value) {
                  setState(() {
                    lista = value;
                  });
                }),
              ),
              ListTile(
                title: Text('Novo Card'),
                trailing: Icon(Icons.add),
                onTap: () =>
                    Navigator.of(context).pushNamed(Cadastro.routename),
              ),
              ListTile(
                title: Text('Atualizar Card'),
                trailing: Icon(Icons.update),
              ),
              ListTile(
                title: Text('Remover Card'),
                trailing: Icon(Icons.delete),
                onTap: () => showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('Insira o id do card a ser excluido'),
                    actions: <Widget>[],
                  ),
                ),
              ),
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
          child: ListView.builder(
            itemCount: lista.length ?? 0,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) async =>
                    await NetworkHelper.deletaCard(lista[index].id),
                background: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.all(10), child: Icon(Icons.delete)),
                  color: Colors.red,
                ),
                key: UniqueKey(),
                child: Card(
                  child: ListTile(
                    leading: Text('id: ${lista[index].id.toString()}'),
                    title: Text(lista[index].title ?? 'Sem título'),
                    subtitle: Text(lista[index].content ?? 'Sem conteúdo'),
                    trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.of(context).pushNamed(
                            Cadastro.routename,
                            arguments: lista[index])),
                    isThreeLine: true,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
