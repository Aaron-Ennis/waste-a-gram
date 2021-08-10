import "dart:io";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:image_picker/image_picker.dart";

// internally-maintained imports
import "../helpers/formatted_date.dart";
import "../screens/new_post_screen.dart";

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  File? image;
  final imagePicker = ImagePicker();

  Future getImage() async {
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    image = File(file!.path);
    var filename = DateTime.now().toString() + ".jpg";
    Reference storageRef = FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = storageRef.putFile(image!);
    await uploadTask;
    final url = await storageRef.getDownloadURL();
    return url;
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NewPostScreen(),
            ),
          );
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
