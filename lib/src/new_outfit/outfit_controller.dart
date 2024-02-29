import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/model/item_model.dart';

class WardrobeController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var tops = <Product>[].obs;
  var bottoms = <Product>[].obs;
  var shoes = <Product>[].obs;
  var selectedTop = Rx<Product?>(null);
  var selectedBottom = Rx<Product?>(null);
  var selectedShoe = Rx<Product?>(null);
  String userId = '';
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    userId = getCurrentUserId();
    fetchProducts();
  }

  void clear() {
    tops.clear();
    bottoms.clear();
    shoes.clear();
    selectedTop.value = null;
    selectedBottom.value = null;
    selectedShoe.value = null;
  }

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      await db
          .collection('product')
          .where('userId', isEqualTo: userId)
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          Product product = Product.fromFirestore(doc);
          if (product.type == 'top') {
            tops.add(product);
          } else if (product.type == 'bottom') {
            bottoms.add(product);
          } else if (product.type == 'shoe') {
            shoes.add(product);
          }
        }
      });
      isLoading.value = false;
    } catch (e) {
      Get.snackbar(
        'Error:',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
    update();
  }

  void shuffleOutfit() {
    final random = Random();
    if (tops.isNotEmpty) {
      selectedTop.value = tops[random.nextInt(tops.length)];
    }
    if (bottoms.isNotEmpty) {
      selectedBottom.value = bottoms[random.nextInt(bottoms.length)];
    }
    if (shoes.isNotEmpty) {
      selectedShoe.value = shoes[random.nextInt(shoes.length)];
    }
  }

  Future<void> saveOutfit() async {
    if (selectedTop.value != null && selectedBottom.value != null) {
      try {
        // Create the document and get its ID
        DocumentReference docRef = await db.collection('outfits').add({
          'userId': userId,
          'top': {
            'image': selectedTop.value!.image,
            'name': selectedTop.value!.name,
          },
          'bottom': {
            'image': selectedBottom.value!.image,
            'name': selectedBottom.value!.name,
          },
          'shoes': {
            'image': selectedShoe.value!.image,
            'name': selectedShoe.value!.name,
          },
          'timestamp': Timestamp.now(),
        });

        // Update the document to set the docId field
        await docRef.update({'docId': docRef.id});

        Get.snackbar(
          'Success:',
          'Outfit saved successfully.',
          backgroundColor: Colors.green,
        );
      } catch (e) {
        Get.snackbar(
          'Error:',
          e.toString(),
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        'Error:',
        'No outfit selected.',
        backgroundColor: Colors.red,
      );
    }
  }
}
