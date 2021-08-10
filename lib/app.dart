import "package:flutter/material.dart";

// internally-maintained imports
import "screens/list_screen.dart";

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Waste-a-gram",
      theme: ThemeData.dark(),
      home: ListScreen(),
    );
  }
}
