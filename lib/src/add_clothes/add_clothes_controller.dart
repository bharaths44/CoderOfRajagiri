import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cor/api_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../view_clothes/all_product_controller.dart';

// Controller for adding products
class AddProductController extends GetxController {
  // Reference to the AllProductsController
  final AllProductsController allProductsController =
      Get.put<AllProductsController>(AllProductsController());

  // Text editing controllers for the product details
  TextEditingController name = TextEditingController();

  TextEditingController color = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController size = TextEditingController();

  // Reference to Firebase Storage
  FirebaseStorage storage = FirebaseStorage.instance;

  // Observable for the image URL
  var inputImageUrl = ''.obs;

  // Observable for the loading state
  var loading = false.obs;

  // Observable for the selected image
  var image = Rx<File?>(null);
  var type = ''.obs;

// Method to get the current user's ID
  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  // Method to upload an image
  Future<void> uploadImage() async {
    final picker = ImagePicker();
    loading.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images/${const Uuid().v1()}');
      final uploadTask = storageRef.putFile(image.value!);

      await uploadTask.whenComplete(() async {
        if (uploadTask.snapshot.state == TaskState.success) {
          final downloadURL = await storageRef.getDownloadURL();

          // Send the image to the remove.bg API for background removal
          final response = await http.post(
            Uri.parse('https://api.remove.bg/v1.0/removebg'),
            headers: {
              'X-Api-Key': apiKey,
            },
            body: {
              'image_url': downloadURL,
              'size': 'auto',
            },
          );

          if (response.statusCode == 200) {
            // Save the processed image to the device
            final directory = await getApplicationDocumentsDirectory();
            final imagePath = '${directory.path}/no-bg${const Uuid().v1()}.png';
            await File(imagePath).writeAsBytes(response.bodyBytes);

            // Upload the processed image to Firebase Storage
            final processedImageRef = FirebaseStorage.instance
                .ref()
                .child('processed_images/${path.basename(imagePath)}');
            await processedImageRef.putFile(File(imagePath));

            // Get the download URL of the processed image
            final processedImageUrl = await processedImageRef.getDownloadURL();

            // Save the download URL of the processed image
            inputImageUrl.value = processedImageUrl;

            loading.value = false;
            update();
          } else {
            print('Error: ${response.statusCode} ${response.reasonPhrase}');
          }
        } else {
          print('Upload failed with state: ${uploadTask.snapshot.state}');
        }
      });
    } else {
      if (kDebugMode) {
        print('No image selected');
      }
      loading.value = false;
    }
  }

  // Method to clear the text fields
  cleartextfields() {
    name.clear();

    color.clear();
    brand.clear();
    size.clear();
    inputImageUrl.value = '';
    image.value = null;
    update();
  }

  // Method to add a product
  Future<void> addProduct() async {
    loading.value = true;
    final product = {
      'name': name.text.toString(),
      'type': type.value.toString(),
      'color': color.text.toString(),
      'brand': brand.text.toString(),
      'size': size.text.toString(),
      'image': inputImageUrl.value,
      'userId': getCurrentUserId(),
    };
    await FirebaseFirestore.instance.collection('product').doc().set(product);
    loading.value = false;
    cleartextfields();
    Get.snackbar(
      duration: const Duration(seconds: 2),
      'Success:',
      'Product added successfully',
      backgroundColor: Colors.green,
    );
    allProductsController.clearproducts();
    allProductsController.getProducts();
    allProductsController.update();
  }
}
