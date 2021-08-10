import 'package:cloud_firestore/cloud_firestore.dart';

class FoodWastePost {
  final Timestamp date;
  final String imageUrl;
  final int quantity;
  final String latitude;
  final String longitude;

  FoodWastePost(
      {required this.date,
      required this.imageUrl,
      required this.quantity,
      required this.latitude,
      required this.longitude});
}
