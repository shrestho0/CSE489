import 'package:_t05_mvvm_partial/user_list/models/user_list_model.dart';
import 'package:_t05_mvvm_partial/user_list/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("MVVM User List"),
        backgroundColor: Colors.red,
      ),
      body: _ui(userViewModel),
    );
  }

  _ui(UserViewModel userViewModel) {
    if (userViewModel.loading) {
      return Container(
        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      );
    }
    if (userViewModel.userErr != null) {
      return Container(
        child: Text("Error"),
      );
    }
    print(userViewModel.userListModel);
    // return Text("xxtyy");

    return ListView.builder(
      itemBuilder: ((context, index) {
        return Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                child: Text(
                  userViewModel.userListModel[index].name.toString(),
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
              )
            ],
          ),
        );
      }),
      itemCount: userViewModel.userListModel.length,
    );
  }
}
