import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:firebase_core/firebase_core.dart";

// locally-maintained imports
import "app.dart";

final orientations = [
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
  DeviceOrientation.portraitUp,
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(orientations);
  runApp(App());
}
