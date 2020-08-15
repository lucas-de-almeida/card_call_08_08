import 'package:card_agora_vai/entities/cards.dart';
import 'package:card_agora_vai/controllers/list_controller.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Cadastro extends StatefulWidget {
  static final routename = 'cadastro';
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  Cards card;
  bool isLoading = false;
  ListController listaService = ListController();

  var _titleController = TextEditingController();
  var _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    card = ModalRoute.of(context).settings.arguments;
    //TODO: Esta lógica precisa ficar fora do Build
    if (card != null) {
      _titleController.text = card.title;
      _contentController.text = card.content;
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: card == null
            ? Text('Adicionar novo card')
            : Text('Editar card ID: ${card.id}'),
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple[900], Colors.teal[900]],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            Divider(),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Title',
                                border: OutlineInputBorder(),
                              ),
                              controller: _titleController,
                              validator: (value) {
                                if (value.length > 1) {
                                  return null;
                                } else {
                                  return 'Título obrigatório';
                                }
                              },
                            ),
                            Divider(),
                            Container(
                              width: double.maxFinite,
                              height: 300,
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                minLines: null,
                                decoration: InputDecoration(
                                  labelText: 'Content',
                                  border: OutlineInputBorder(),
                                ),
                                controller: _contentController,
                                validator: (value) {
                                  if (value.length > 3) {
                                    return null;
                                  } else {
                                    return 'Conteúdo obrigatório';
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.teal[800],
                                        Colors.purple[900],
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                              child: FlatButton(
                                onPressed: () async {
                                  if (card == null) {
                                    await listaService.salvarCard(
                                      Cards(
                                          title: _titleController.text,
                                          content: _contentController.text),
                                    );
                                    Navigator.of(context)
                                        .popAndPushNamed(HomePage.routename);
                                  } else {
                                    card.title = _titleController.text;
                                    card.content = _contentController.text;
                                    listaService.editarCard(card);
                                    print(isLoading);
                                    setState(() {
                                      isLoading = true;
                                    });

                                    print(isLoading);
                                    await Future.delayed(Duration(seconds: 3));
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print(isLoading);
                                    Navigator.of(context)
                                        .popAndPushNamed(HomePage.routename);
                                  }
                                },
                                //TODO: Criar funções salvar e editar em Networking_helper
                                child: card == null
                                    ? Text('Cadastrar')
                                    : Text('Alterar'),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
