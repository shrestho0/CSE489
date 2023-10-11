import 'package:_t05_mvvm_partial/user_list/models/user_list_model.dart';

class Success {
  int code;
  List<UserListModel> data;
  Success({required this.code, required this.data});
}

class Failure {
  ResponseErrorCodes errCode;
  String errMessage;
  Object? data;

  Failure({required this.errCode, required this.errMessage, this.data});
}

enum ResponseErrorCodes {
  INVALID_RESPONSE,
  NO_INTERNET,
  INVALID_FORMAT,
  UNKNOWN_ERROR
}
