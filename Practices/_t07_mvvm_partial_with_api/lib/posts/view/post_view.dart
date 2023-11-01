import 'package:_t07_mvvm_partial_with_api/posts/model/post_model.dart';
import 'package:_t07_mvvm_partial_with_api/posts/view_model/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    PostsViewModel postViewModel = context.watch<PostsViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Some app"),
        centerTitle: true,
        backgroundColor: Colors.teal[50],
      ),
      body: Center(child: _ui(postViewModel)),
    );
  }

  Widget _ui(PostsViewModel postsViewModel) {
    if (postsViewModel.loading) {
      return CircularProgressIndicator();
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${postsViewModel.postList[index].title}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SinglePostView(
                        singlePost: postsViewModel.postList[index]);
                  },
                ),
              );
            },
          );
        },
        itemCount: postsViewModel.postList.length,
      );
    }
  }
}

class SinglePostView extends StatelessWidget {
  final SinglePostModel singlePost;
  const SinglePostView({super.key, required this.singlePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post title with id: ${singlePost.id}"),
      ),
      body: Column(children: [
        Text("id: " + singlePost.id.toString()),
        Text("userId " + singlePost.userId.toString()),
        SizedBox(height: 20),
        Text("title " + singlePost.title.toString()),
        SizedBox(height: 20),
        Text("body\n" + singlePost.body),
      ]),
    );
  }
}
