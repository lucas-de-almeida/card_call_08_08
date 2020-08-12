class User {
  int id;
  String token = '';
  String email = '';
  String nome = '';
  bool isLogged = false;

  User({this.email, this.nome, this.token});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['token'] = token;
    data['email'] = email;
    data['nome'] = nome;
    data['isLogged'] = isLogged ? 1 : 0;

    return data;
  }

  User.fromMap(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'];
    nome = json['nome'];
    isLogged = json['isLogger'] == 1 ? true : false;
  }
}