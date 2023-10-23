import 'package:_t02_firebase_auth/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreCrudPage extends StatefulWidget {
  const FireStoreCrudPage({super.key});

  @override
  State<FireStoreCrudPage> createState() => _FireStoreCrudPageState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class _FireStoreCrudPageState extends State<FireStoreCrudPage> {
  final userNameController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('_t02');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('_t02').snapshots();

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users.add({
      'full_name':
          userNameController.text != "" ? userNameController.text : "No Data",
      'date': DateTime.now().toString(),
    }).then((value) {
      print("User Added;");
      userNameController.clear();
      print("Username field cleared;");
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.createAppBar("FireStore CRUD"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Some Stuff',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              controller: userNameController,
            ),
            OutlinedButton(
              onPressed: addUser,
              child: Text("add user"),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot);
                  if (snapshot.hasError) return Text("Error");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("waiting");
                  }

                  return ListView(
                    children: [
                      ...snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Text("${data["full_name"]} :: ${data["date"]}");
                      }).toList()
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
