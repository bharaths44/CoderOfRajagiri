import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/model/item_model.dart';

class AllProductsController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  var isLoading = true.obs;
  String userId = '';
  @override
  void onInit() {
    super.onInit();
    userId = getCurrentUserId();
    getProducts();
  }

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  clearproducts() {
    products.clear();
    update();
  }

  Future<RxList<Product>> getProducts() async {
    try {
      isLoading.value = true;
      products.clear();
      await db
          .collection('product')
          .where('userId', isEqualTo: userId)
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          products.add(Product.fromFirestore(doc));
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
    return products;
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await db.collection('product').doc(product.docId).delete();
      products.remove(product);
      getProducts();
      Get.offAllNamed('/home/');

      update();
    } catch (e) {
      Get.snackbar(
        'Error:',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
