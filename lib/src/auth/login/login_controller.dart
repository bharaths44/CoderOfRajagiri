import 'package:cor/src/new_outfit/outfit_controller.dart';
import 'package:cor/src/view_outfits/view_outfits_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_screen/home_controller.dart';
import '../../view_clothes/all_product_controller.dart';

class LoginController extends GetxController {
  final DashBoardController dashboardController =
      Get.find<DashBoardController>();
  final AllProductsController controller = Get.find<AllProductsController>();
  final ViewOutfitController viewOutfitController =
      Get.find<ViewOutfitController>();
  final WardrobeController wardrobeController = Get.find<WardrobeController>();
  final email = TextEditingController();
  final password = TextEditingController();

  void clearControllers() {
    email.clear();
    password.clear();
  }

  void executeOnInitLogic() {
    controller.getCurrentUserId();
    controller.onInit();
    viewOutfitController.onInit();
    wardrobeController.onInit();
  }

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      executeOnInitLogic();
      Get.offAllNamed('/home/');
    } on FirebaseAuthException catch (e) {
      Map<String, String> errors = {
        'user-not-found': 'No user found for that email.',
        'wrong-password': 'Wrong password provided for that user.',
        'user-disabled': 'This user has been disabled.',
        'too-many-requests': 'Too many requests. Try again later.',
        'operation-not-allowed': 'Operation not allowed.',
        'invalid-email': 'The email address is not valid.',
        'account-exists-with-different-credential':
            'The email is already in use by another account.',
        'credential-already-in-use': 'The account already exists.',
        'invalid-credential': 'Invalid credentials.',
      };

      Get.snackbar(
        'Error',
        errors[e.code] ?? e.code,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        forwardAnimationCurve: Curves.easeOutCubic,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        forwardAnimationCurve: Curves.easeOutCubic,
      );
    }
  }

  void logout() async {
    dashboardController.initTabIndex();
    await FirebaseAuth.instance.signOut();
    controller.clearproducts();
    viewOutfitController.clearOutfits();
    wardrobeController.clear();
    clearControllers();
    Get.offAllNamed('/login/');
  }

  void forgotPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      Get.snackbar(
        'Success',
        'Password reset email sent. Please check your email.',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        forwardAnimationCurve: Curves.easeOutCubic,
      );
      clearControllers();
      Get.offAllNamed('/login/');
    } catch (e) {
      Get.snackbar(
        'Error:',
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        forwardAnimationCurve: Curves.easeOutCubic,
      );
    }
  }
}
