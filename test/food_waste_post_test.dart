import "package:cloud_firestore/cloud_firestore.dart";
import "package:test/test.dart";
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  final date = Timestamp.now();
  const imageUrl = "Fake Url";
  const quantity = 1;
  const latitude = 2.0;
  const longitude = 3.0;
  test("Post created from a Map should have appropriate property values", () {
    final foodWastePost = FoodWastePost.fromMap({
      "date": date,
      "imageUrl": imageUrl,
      "quantity": quantity,
      "latitude": latitude,
      "longitude": longitude
    });

    expect(foodWastePost.date, date);
    expect(foodWastePost.imageUrl, imageUrl);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });

  test("Post's 'date' value should be a Timestamp object", () {
    final post = FoodWastePost(
        date: date,
        imageUrl: imageUrl,
        quantity: quantity,
        latitude: latitude,
        longitude: longitude);

    expect(post.date, isA<Timestamp>());
  });

  test("Post's quantity shoud be greater than or equal to zero", () {
    final post = FoodWastePost(
        date: date,
        imageUrl: imageUrl,
        quantity: quantity,
        latitude: latitude,
        longitude: longitude);

    expect(post.quantity, greaterThanOrEqualTo(0));
  });
}
