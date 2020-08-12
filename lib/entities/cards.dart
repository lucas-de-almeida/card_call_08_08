class Cards {
  int id;
  String title;
  String content;
  String createdAt;
  String updatedAt;

  Cards({this.id, this.title, this.content, this.createdAt, this.updatedAt});

  Cards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = this.title;
    data['content'] = this.content;

    return data;
  }
}
