import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";

// locally-maintained imports
import "app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}
