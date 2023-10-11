import 'dart:async';
import 'dart:io';

import 'package:_t05_mvvm_partial/constants.dart';
import 'package:_t05_mvvm_partial/user_list/models/user_list_model.dart';
import 'package:_t05_mvvm_partial/user_list/repo/api_services.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static Future<Object> getUsers() async {
    try {
      var url = Uri.parse(USER_LIST);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return Success(
            code: response.statusCode,
            data: userListModelFromJson(response.body));
      }

      return Failure(
          errCode: ResponseErrorCodes.INVALID_RESPONSE,
          errMessage: 'Invalid Response');
    } on HttpException {
      return Failure(
          errCode: ResponseErrorCodes.NO_INTERNET, errMessage: 'No Internet');
    } on FormatException {
      return Failure(
          errCode: ResponseErrorCodes.INVALID_FORMAT,
          errMessage: 'Invalid Format');
    } catch (e) {
      print(e);
      return Failure(
          errCode: ResponseErrorCodes.UNKNOWN_ERROR,
          errMessage: 'Unknown error occured!');
    }
  }
}
