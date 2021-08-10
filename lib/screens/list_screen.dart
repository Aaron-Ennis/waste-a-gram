import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

// internally-maintained imports
import '../helpers/formatted_date.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text("Waste-A-Gram"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data!.docs[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatDate(post["date"]), style: style),
                      Text(post["quantity"].toString(), style: style),
                    ],
                  ),
                );
              },
            );
          } else {
            return (Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
