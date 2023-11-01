import 'dart:async';
import 'dart:convert';

import 'package:_t07_mvvm_partial_with_api/posts/model/post_model.dart';
import 'package:_t07_mvvm_partial_with_api/posts/model/post_service.dart';
import 'package:flutter/material.dart';

class PostsViewModel extends ChangeNotifier {
  PostsViewModel() {
    getPosts();
  }

  bool _loading = false;
  List<SinglePostModel> _postList = [];

  get loading => _loading;
  get postList => _postList;

  void setLoading(bool status) {
    _loading = status;
    notifyListeners();
  }

  void setPostListModel(List<SinglePostModel> posts) {
    _postList = posts;
  }

  Future<void> getPosts() async {
    setLoading(true);
    // print("making stuff");
    var responseX = await PostsService.getPostsFromRequest();
    if (responseX is Success) {
      setPostListModel(responseX.data);
      // _postList = postListFromJson(responseX.data);
      // print(_postList);
    } else if (responseX is Failure) {
      print(responseX.message);
    }
    setLoading(false);
    // setPostListModel(responseX);
  }
}
