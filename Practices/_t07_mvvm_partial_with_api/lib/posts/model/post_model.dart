import 'dart:convert';

List<SinglePostModel> postListFromJson(String str) =>
    List<SinglePostModel>.from(
        json.decode(str).map((x) => SinglePostModel.fromJson(x)));

String userListModelToJson(List<SinglePostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SinglePostModel {
  int userId;
  int id;
  String title;
  String body;

  SinglePostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory SinglePostModel.fromJson(Map<String, dynamic> json) {
    print("deserializing json $json");
    return SinglePostModel(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": id,
      "id": id,
      "title": title,
      "body": body,
    };
  }
}
