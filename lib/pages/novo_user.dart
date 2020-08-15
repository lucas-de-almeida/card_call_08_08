import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  static final routeName = 'newUser';
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  var _passwordDone = false;
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de usuário'),
        backgroundColor: Colors.purple[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/wall.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    icon: Icon(
                      Icons.person,
                    ),
                    // labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  //controller: _nomeController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                    // labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nova senha',
                    icon: Icon(Icons.lock),
                    // labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  onEditingComplete: () => _passwordDone = true,
                  onFieldSubmitted: (_) {
                    setState(() {
                      _passwordDone = true;
                    });
                  },
                ),
              ),
              Visibility(
                visible: _passwordDone,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autofocus: true,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      labelText: 'Repita a senha',
                      icon: Icon(Icons.lock),
                      // labelText: 'Senha',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
