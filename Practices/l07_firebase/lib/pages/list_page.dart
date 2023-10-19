import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Items"),
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("ItemX: $index"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListItemDetails(itemIndex: index),
                  ));
            },
          );
        },
      ),
    );
  }
}

// There will be a detail view class

class ListItemDetails extends StatelessWidget {
  const ListItemDetails({super.key, required this.itemIndex});
  final itemIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Details of $itemIndex"),
      ),
      body: Container(
          child: Column(
        children: [
          Text(
            "$itemIndex",
            style: TextStyle(fontSize: 20),
          )
        ],
      )),
    );
  }
}
