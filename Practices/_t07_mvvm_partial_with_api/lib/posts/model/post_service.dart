import 'dart:convert';
import 'dart:io';
import 'package:_t07_mvvm_partial_with_api/posts/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostsService {
  static getPostsFromRequest() async {
    try {
      var postUrl = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      var response = await http.get(postUrl);
      if (response.statusCode == 200) {
        // print("response paisi ${response.body}");
        return Success(
          code: response.statusCode,
          data: postListFromJson(response.body),
        );
      }
      return Failure(
          code: ResponseErrorCodes.INVALID_RESPONSE,
          message: "Invalid response");
    } on HttpException {
      return Failure(
          code: ResponseErrorCodes.NO_INTERNET, message: "No Internet");
    } on FormatException {
      return Failure(
          code: ResponseErrorCodes.INVALID_FORMAT, message: "Invalid Format");
    } catch (e) {
      print(e);
      return Failure(
          code: ResponseErrorCodes.UNKNOWN_ERROR, message: "Unknown Error");
    }
  }

  static getSinglePostFromRequest(String postId) async {
    try {
      var postUrl =
          Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId");

      var response = await http.get(postUrl);

      if (response.statusCode == 200) {
        return Success(
          code: response.statusCode,
          data: SinglePostModel.fromJson(json.decode(response.body)),
        );
      }
      return Failure(
          code: ResponseErrorCodes.INVALID_RESPONSE,
          message: "Invalid response");
    } on HttpException {
      return Failure(
          code: ResponseErrorCodes.NO_INTERNET, message: "No Internet");
    } on FormatException {
      return Failure(
          code: ResponseErrorCodes.INVALID_FORMAT, message: "Invalid Format");
    } catch (e) {
      print(e);
      return Failure(
          code: ResponseErrorCodes.UNKNOWN_ERROR, message: "Unknown Error");
    }
  }
}

class Success {
  int code;
  dynamic data;
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
