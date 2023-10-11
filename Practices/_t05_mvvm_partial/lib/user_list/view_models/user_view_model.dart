import 'package:_t05_mvvm_partial/user_list/models/user_errors.dart';
import 'package:_t05_mvvm_partial/user_list/models/user_list_model.dart';
import 'package:_t05_mvvm_partial/user_list/repo/api_services.dart';
import 'package:_t05_mvvm_partial/user_list/repo/user_services.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserListModel> _userListModel = [];
  UserError? _userErr;

  // constructor
  UserViewModel() {
    getUsers();
  }

  bool get loading => _loading;
  UserError? get userErr => _userErr;
  List<UserListModel> get userListModel => _userListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setError(UserError err) => _userErr = err;

  setUserListModel(List<UserListModel> userListModel) {
    _userListModel = userListModel;
  }

  getUsers() async {
    setLoading(true);
    var response = await UserServices.getUsers();
    print("User khoja hocche $response");
    if (response is Success) {
      setUserListModel(response.data);
    } else if (response is Failure) {
      UserError err = UserError(
        code: response.errCode.index,
        message: response.errMessage,
      );
      setError(err);
    }
    setLoading(false);
  }

  // setUserError(UserError)
}
