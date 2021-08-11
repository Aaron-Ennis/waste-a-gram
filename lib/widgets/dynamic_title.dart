import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class DynamicTitle extends StatefulWidget {
  @override
  _DynamicTitleState createState() => _DynamicTitleState();
}

class _DynamicTitleState extends State<DynamicTitle> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("posts").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.length > 0) {
          int totalWaste = 0;
          snapshot.data!.docs.forEach((doc) {
            totalWaste += doc["quantity"] as int;
          });
          return Text(
            "Waste-A-Gram-" + totalWaste.toString(),
          );
        } else {
          return Text("Waste-A-Gram-0");
        }
      },
    );
  }
}
