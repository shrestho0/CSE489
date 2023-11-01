import 'package:_t07_mvvm_partial_with_api/posts/view/post_view.dart';
import 'package:_t07_mvvm_partial_with_api/posts/view_model/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostsViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PostsView(),
      ),
    );
  }
}

// class TheHolyApp extends StatelessWidget {
//   const TheHolyApp({super.key});

//   @override
//   
// }
