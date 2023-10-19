import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

CollectionReference colRef = FirebaseFirestore.instance.collection('test489');

DateTime getCurrentDateTime() {
  return DateTime.now();
}

class _DataPageState extends State<DataPage> {
  List<Widget> document = [];
  List<String> docIds = [];

  void addData() async {
    var dataToAdd = {"createdAt": getCurrentDateTime().toString()};

    await colRef.add(dataToAdd);
  }

  void deleteAllData() async {
    for (String idx in docIds) {
      var something = colRef.doc(idx);
      print(something.toString());

      something.delete();
    }
    // FirebaseFirestore.instance
    //     .collection('test489')
    //     .snapshots()
    //     .listen((event) {
    //   for (var element in event.docs) {
    //     // print(element);
    //     element.reference.delete();
    //   }
    // });
    setState(() {
      document = [];
    });
    // collection('messages').getDocuments().then((snapshot) {
    //   for (DocumentSnapshot ds in snapshot.docs) {
    //     ds.reference.delete();
    //   }
    //   ;
    // });
  }

  void fetchData() {
    colRef.snapshots().listen((event) {
      // print(event.docs[0].data());
      setState(() {
        if (event.docs.isNotEmpty) {
          document = [];
          event.docs.toList().forEach((element) {
            // print(element.data().toString());
            Widget doc = Text(element.data().toString());
            document.add(doc);
            docIds.add(element.id);
          });
        } else {
          document = [];
          docIds = [];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        const Text("Firebase Data"),
        ElevatedButton(
            onPressed: addData, child: const Text("Add Random Data")),
        ElevatedButton(
            onPressed: deleteAllData, child: const Text("Delete all data")),
        ElevatedButton(onPressed: fetchData, child: const Text("Fetch Data")),
        Expanded(
            child: ListView(
          children: document.isNotEmpty
              ? document
              : [
                  Center(
                    child: Text("No Data :3"),
                  )
                ],
        ))
      ]),
    );
  }
}
