import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Outfit {
  final String docId;
  final Timestamp timestamp;
  final Map top;
  final Map bottom;
  final Map shoes;
  final String userId;

  Outfit({
    required this.docId,
    required this.timestamp,
    required this.top,
    required this.bottom,
    required this.shoes,
    required this.userId,
  });

  factory Outfit.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Outfit(
      docId: doc.id,
      timestamp: data['timestamp'],
      top: data['top'],
      bottom: data['bottom'],
      shoes: data['shoes'],
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "docId": docId,
      "timestamp": timestamp,
      "top": top,
      "bottom": bottom,
      "shoes": shoes,
      "userId": userId,
    };
  }
}
