import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();

  void clearControllers() {
    name.clear();
    email.clear();
    password.clear();
    phoneNumber.clear();
  }

  void signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name.text,
          'email': email.text,
          'phoneNumber': phoneNumber.text,
        });
        Get.snackbar(
          'Success',
          'Registration successful',
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          forwardAnimationCurve: Curves.easeOutCubic,
        );

        Get.toNamed('/verifyemail/');
        clearControllers();
      }
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
