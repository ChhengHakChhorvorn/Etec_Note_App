import 'package:flutter/foundation.dart';

class NoteModel {
  int? id;
  String? title;
  String? body;
  String? category;
  String? color;
  String? creationDate;

  NoteModel(
      {this.id,
      this.title,
      this.body,
      this.category,
      this.creationDate,
      this.color});

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "category": category,
      "color": color,
      "creationDate": creationDate
    });
  }

  NoteModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        body = res["body"],
        category = res["category"],
        color = res["color"],
        creationDate = res["creationDate"];
}
