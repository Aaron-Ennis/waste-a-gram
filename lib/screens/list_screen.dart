import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

// internally-maintained imports
import "../helpers/formatted_date.dart";
import "../helpers/get_image.dart";
import "../screens/detail_screen.dart";
import "../screens/new_post_screen.dart";

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late bool loading;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.headline6;
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.length > 0) {
            // Calculate the total waste to display in the AppBar
            int totalWaste = 0;
            snapshot.data!.docs.forEach((doc) {
              totalWaste += doc["quantity"] as int;
            });
            return Scaffold(
              appBar: AppBar(
                title: Text("Waste-A-Gram-" + totalWaste.toString()),
                centerTitle: true,
              ),
              body: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data!.docs[index];
                  return Semantics(
                    button: true,
                    enabled: true,
                    onTapHint: "View post details",
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatDate(post["date"]), style: style),
                          Text(post["quantity"].toString(), style: style),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailScreen(post: post),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              floatingActionButton: cameraFab(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Waste-A-Gram-0"),
                centerTitle: true,
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
              floatingActionButton: cameraFab(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        },
      );
    }
  }

  // There is probably a cleaner way to trigger the Circular Progress
  // Indicator than using a boolean state variable when waiting for the async
  // to return. This works for now, but need to research...
  void onPressed() async {
    setState(() {
      loading = true;
    });

    final url = await getImage();

    setState(() {
      loading = false;
    });

    if (url == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => NewPostScreen(imageUrl: url),
      ),
    );
  }

  Widget cameraFab() {
    return Semantics(
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.camera_alt),
      ),
      button: true,
      enabled: true,
      onTapHint: "Select an image and open post screen",
    );
  }
}
