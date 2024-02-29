import 'package:cloud_firestore/cloud_firestore.dart';

class Outfit {
  final String docId;
  final Timestamp timestamp;
  final Map top;
  final Map bottom;
  final Map shoes;

  Outfit({
    required this.docId,
    required this.timestamp,
    required this.top,
    required this.bottom,
    required this.shoes,
  });

  factory Outfit.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Outfit(
      docId: doc.id,
      timestamp: data['timestamp'],
      top: data['top'],
      bottom: data['bottom'],
      shoes: data['shoes'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "docId": docId,
      "timestamp": timestamp,
      "top": top,
      "bottom": bottom,
      "shoes": shoes,
    };
  }
}
