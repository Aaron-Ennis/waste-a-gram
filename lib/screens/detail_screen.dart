import "package:flutter/material.dart";
import "../widgets/image_container.dart";

// internally-maintained imports
import "../helpers/formatted_date.dart";
import "../models/food_waste_post.dart";

class DetailScreen extends StatelessWidget {
  final post;

  const DetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodWastePost foodWastePost =
        FoodWastePost.fromJSON(post.data()! as Map<String, dynamic>);
    return Scaffold(
      appBar: AppBar(
        title: Text("Waste-A-Gram"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  formatDate(foodWastePost.date),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
          ImageContainer(imageUrl: foodWastePost.imageUrl),
          Expanded(
            child: Center(
              child: Text(
                foodWastePost.quantity.toString() + " items",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          Expanded(
            child: Text("Location (" +
                foodWastePost.latitude.toString() +
                ", " +
                foodWastePost.longitude.toString() +
                ")"),
          )
        ],
      ),
    );
  }
}
