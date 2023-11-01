import 'dart:convert';

List<FootballScoreModel> gameListFromJson(String str) =>
    List<FootballScoreModel>.from(
        json.decode(str).map((x) => FootballScoreModel.fromJson(x)));

String gameListToJson(List<FootballScoreModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FootballScoreModel {
  String Tournament;
  int Match_Id;
  String Match_name;
  String TeamA;
  String TeamB;
  String Score;

  FootballScoreModel(
      {required this.Tournament,
      required this.Match_Id,
      required this.Match_name,
      required this.TeamA,
      required this.TeamB,
      required this.Score});

  factory FootballScoreModel.fromJson(Map<String, dynamic> json) {
    // print("deserializing json $json");
    return FootballScoreModel(
      Tournament: json["Tournament"],
      Match_Id: json["Match_Id"],
      Match_name: json["Match_name"],
      TeamA: json["TeamA"],
      TeamB: json["TeamB"],
      Score: json["Score"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Tournament": Tournament,
      "Match_Id": Match_Id,
      "Match_name": Match_name,
      "TeamA": TeamA,
      "TeamB": TeamB,
      "Score": Score,
    };
  }
}
