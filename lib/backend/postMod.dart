// ============================================================
// ============================================================
// ============================================================

class PostModel {
  int? id;
  String? title;
  String? body;

  PostModel({this.id, this.body, this.title});

  PostModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
  Map<String, dynamic> toJson() => {
        MyDataFields.id: id,
        MyDataFields.title: title,
        MyDataFields.body: body,
      };
}

class MyDataFields {
  static final List<String> values = [id, title, body];
  static const String id = 'userId';
  static const String title = 'title';
  static const String body = 'body';
}
