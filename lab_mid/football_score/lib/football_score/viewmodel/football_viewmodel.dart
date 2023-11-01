import 'package:flutter/material.dart';
import 'package:football_score/football_score/model/football_model.dart';
import 'package:football_score/football_score/services/football_api_services.dart';

class FootballViewModel extends ChangeNotifier {
  bool _loading = false;
  String _errMsg = "";
  bool _hasError = false;

  List<FootballScoreModel> _scoreList = [];

  get loading => _loading;
  get scoreList => _scoreList;

  get hasError => _hasError;
  get errMsg => _errMsg;

  FootballViewModel() {}

  void setFootballScores(List<FootballScoreModel> scores) {
    _scoreList = scores;
  }

  void setLoading(bool status) {
    _loading = status;
    notifyListeners();
  }

  Future<void> getFootballScores() async {
    // loading
    setLoading(true);
    // get football score from api [Success/Failure]
    var responseX = await FootballApiService.getPostsFromRequest();

    if (responseX is Success) {
      _hasError = false;
      // print(responseX.data);
      setFootballScores(responseX.data);
      // setLoading(false);
    } else if (responseX is Failure) {
      print("Some error with Failure");
      print("$responseX ${responseX.message} ${responseX.code}");

      _hasError = true;
      _errMsg = responseX.message;
      setLoading(false);

      // setLoading(false);
    }

    setLoading(false);
    // setLoading(false);
  }
}
