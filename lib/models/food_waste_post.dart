import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory FoodWastePost.fromJSON(Map<String, dynamic> json) {
    return FoodWastePost(
      date: json["date"],
      imageUrl: json["imageUrl"],
      quantity: json["quantity"] as int,
      latitude: json["latitude"] as double,
      longitude: json["longitude"] as double,
    );
  }
}
