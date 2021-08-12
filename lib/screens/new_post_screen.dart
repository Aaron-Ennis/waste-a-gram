import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:location/location.dart";
import "package:flutter/services.dart";

// internally-maintained imports
import "../widgets/image_container.dart";

class NewPostScreen extends StatefulWidget {
  final imageUrl;
  const NewPostScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final formKey = GlobalKey<FormState>();
  late int quantity;
  LocationData? locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print("Failed to enable service. Returning.");
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print("Location service permission not granted. Returning.");
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print("Error: ${e.toString()}, code: ${e.code}");
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: ImageContainer(imageUrl: widget.imageUrl)),
            Expanded(child: quantityFormField()),
            Semantics(
              child: postButton(),
              button: true,
              enabled: true,
              onTapHint: "Upload a post",
            ),
          ],
        ),
      ),
    );
  }

  // Function to encapsulate the widget for quantity entry
  Widget quantityFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: "Number of wasted items",
          //floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        onSaved: (value) {
          quantity = int.parse(value!);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter number of wasted items";
          } else {
            return null;
          }
        },
      ),
    );
  }

  // Function to encapsulate the widget for the upload/post button
  Widget postButton() {
    return GestureDetector(
      onTap: uploadPost,
      child: Container(
        color: Theme.of(context).colorScheme.secondaryVariant,
        height: MediaQuery.of(context).size.height * 0.12,
        child: Center(
          child: Icon(
            Icons.cloud_upload,
            size: MediaQuery.of(context).size.height * 0.1,
          ),
        ),
      ),
    );
  }

  void uploadPost() async {
    if (formKey.currentState!.validate()) {
      Timestamp date = Timestamp.now();
      formKey.currentState!.save();
      await FirebaseFirestore.instance.collection("posts").add({
        "date": date,
        "imageUrl": widget.imageUrl,
        "quantity": quantity,
        "latitude": locationData!.latitude,
        "longitude": locationData!.longitude
      });
      Navigator.pop(context);
    }
  }
}
