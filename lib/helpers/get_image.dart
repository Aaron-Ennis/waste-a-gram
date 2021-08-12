import "dart:io";
import "package:firebase_storage/firebase_storage.dart";
import "package:image_picker/image_picker.dart";

// This helper function opens the device's image gallery for selection
// and uploads the image to cloud storage. It then returns the URL for
// the uploaded file
Future getImage() async {
  File? image;
  final imagePicker = ImagePicker();
  final file = await imagePicker.pickImage(source: ImageSource.gallery);
  if (file == null) {
    return null;
  }
  image = File(file.path);
  var filename = DateTime.now().toString() + ".jpg";
  Reference storageRef = FirebaseStorage.instance.ref().child(filename);
  UploadTask uploadTask = storageRef.putFile(image);
  await uploadTask;
  final url = await storageRef.getDownloadURL();
  return url;
}
