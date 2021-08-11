import "package:flutter/material.dart";

// internally-maintained imports
import "../helpers/get_image.dart";
import "../screens/new_post_screen.dart";

class UploadButton extends StatefulWidget {
  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
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
}
