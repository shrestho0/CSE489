import 'dart:io';
import 'package:football_score/constants.dart';
import 'package:football_score/football_score/model/football_model.dart';
import 'package:http/http.dart' as http;

class FootballApiService {
  static getPostsFromRequest() async {
    try {
      // TODO: place this url to some constants' place
      var postUrl = Uri.parse(AppConstants.football_api);
      var response = await http.get(postUrl);
      if (response.statusCode == 200) {
        // print("response paisi ${response.body}");
        return Success(
          code: response.statusCode,
          data: gameListFromJson(response.body),
        );
      }
      return Failure(
          code: ResponseErrorCodes.INVALID_RESPONSE,
          message: "Invalid response");
    } on SocketException {
      return Failure(
          code: ResponseErrorCodes.NO_INTERNET, message: "No Internet");
    } on HttpException {
      return Failure(
          code: ResponseErrorCodes.NO_INTERNET, message: "No Internet");
    } on FormatException {
      return Failure(
          code: ResponseErrorCodes.INVALID_FORMAT, message: "Invalid Format");
    } catch (e) {
      print("ERROR WITH API");
      print(e);
      return Failure(
          code: ResponseErrorCodes.UNKNOWN_ERROR, message: "Unknown Error");
    }
  }
}

class Success {
  int code;
  List<FootballScoreModel> data;
  Success({required this.code, required this.data});
}

class Failure {
  ResponseErrorCodes code;
  String message;
  Failure({required this.code, required this.message});
}

enum ResponseErrorCodes {
  INVALID_RESPONSE,
  NO_INTERNET,
  INVALID_FORMAT,
  UNKNOWN_ERROR
}
