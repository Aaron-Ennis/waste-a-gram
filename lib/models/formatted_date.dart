import 'package:cloud_firestore/cloud_firestore.dart';
import "package:intl/intl.dart";

String formatDate(Timestamp date) {
  final DateFormat format = DateFormat("EEEE, LLLL d, y");
  return format.format(date.toDate());
}
