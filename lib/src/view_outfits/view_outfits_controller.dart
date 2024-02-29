import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../core/model/outfit_model.dart';

class ViewOutfitController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  // final firebase_storage.FirebaseStorage _storage =
  //     firebase_storage.FirebaseStorage.instance;
  RxList<Outfit> outfits = RxList<Outfit>();
  String userId = '';
  @override
  void onInit() {
    userId = getCurrentUserId();
    fetchOutfits();
    super.onInit();
  }

  clearOutfits() {
    outfits.clear();
    update();
  }

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> fetchOutfits() async {
    try {
      final snapshot = await db
          .collection('outfits')
          .where('userId', isEqualTo: userId)
          .get();

      outfits.clear();
      for (var doc in snapshot.docs) {
        outfits.add(Outfit.fromFirestore(doc));
      }

      print('Outfits :$outfits');
    } catch (e) {
      print('Error fetching outfits: $e');
    }
  }

  Future<void> removeOutfit(String outfitId) async {
    await db.collection('outfits').doc(outfitId).delete();
  }

  Future<String> fetchTopImage(Outfit outfit) async {
    if (outfit.top['image'] != null) {
      return outfit.top['image'];
    }
    throw Exception('Top image does not exist');
  }

  Future<String> fetchBottomImage(Outfit outfit) async {
    if (outfit.bottom['image'] != null) {
      return outfit.bottom['image'];
    }
    throw Exception('Bottom image does not exist');
  }

  Future<String> fetchShoeImage(Outfit outfit) async {
    if (outfit.shoes['image'] != null) {
      return outfit.shoes['image'];
    }
    throw Exception('Shoe image does not exist');
  }

  Map<String, dynamic> getOutfitDetails(Outfit outfit) {
    return outfit.toFirestore();
  }
}
