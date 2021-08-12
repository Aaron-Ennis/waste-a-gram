import "package:cloud_firestore/cloud_firestore.dart";

class FoodWastePost {
  final Timestamp date;
  final String imageUrl;
  final int quantity;
  final double latitude;
  final double longitude;

  FoodWastePost(
      {required this.date,
      required this.imageUrl,
      required this.quantity,
      required this.latitude,
      required this.longitude});

  factory FoodWastePost.fromMap(Map<String, dynamic> data) {
    return FoodWastePost(
      date: data["date"],
      imageUrl: data["imageUrl"],
      quantity: data["quantity"] as int,
      latitude: data["latitude"] as double,
      longitude: data["longitude"] as double,
    );
  }
}
