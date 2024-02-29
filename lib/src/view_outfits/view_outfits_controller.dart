import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../core/model/outfit_model.dart';

class ViewOutfitController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final firebase_storage.FirebaseStorage _storage =
  //     firebase_storage.FirebaseStorage.instance;
  RxList<Outfit> outfits = RxList<Outfit>();

  @override
  void onInit() {
    outfits.bindStream(
        fetchOutfits()); // fetch outfits when the controller is initialized
    super.onInit();
  }

  clearOutfits() {
    outfits.clear();
    update();
  }

  Stream<List<Outfit>> fetchOutfits() {
    return _firestore.collection('outfits').snapshots().map(
        (query) => query.docs.map((doc) => Outfit.fromFirestore(doc)).toList());
  }

  Future<void> removeOutfit(String outfitId) async {
    await _firestore.collection('outfits').doc(outfitId).delete();
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
