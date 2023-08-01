// // To parse this JSON data, do
// //
// //     final model = modelFromJson(jsonString);
//
// import 'dart:convert';
//
// List<Model> modelFromJson(String str) => List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));
//
// String modelToJson(List<Model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  Model({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );


  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
