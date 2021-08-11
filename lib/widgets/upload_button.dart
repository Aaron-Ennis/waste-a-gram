import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

// internally-maintained imports
import "../helpers/get_image.dart";
import "../screens/new_post_screen.dart";

class UploadButton extends StatefulWidget {
  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  // File? image;
  // final imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onPressed(context);
      },
      child: Icon(Icons.camera_alt),
    );
  }

  void onPressed(BuildContext context) async {
    final url = await getImage();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => NewPostScreen(imageUrl: url),
      ),
    );
  }

  // Boilerplate function to upload an image to cloud storage and get its url
  // Future getImage() async {
  //   final file = await imagePicker.pickImage(source: ImageSource.gallery);
  //   image = File(file!.path);
  //   var filename = DateTime.now().toString() + ".jpg";
  //   Reference storageRef = FirebaseStorage.instance.ref().child(filename);
  //   UploadTask uploadTask = storageRef.putFile(image!);
  //   await uploadTask;
  //   final url = await storageRef.getDownloadURL();
  //   return url;
  // }
}
