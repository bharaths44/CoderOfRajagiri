import 'package:cor/src/home_screen/home_screen.dart';
import 'package:cor/src/update_clothes/update_clothes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/customappbar.dart';

class UpdateProductScreen extends StatelessWidget {
  final UpdateProductController controller =
      Get.put(UpdateProductController(Get.arguments));

  UpdateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Update Products',
        leading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: controller.name,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextFormField(
                controller: controller.color,
                decoration: const InputDecoration(labelText: 'Product Color'),
              ),
              TextFormField(
                controller: controller.brand,
                decoration: const InputDecoration(labelText: 'Product Brand'),
              ),
              TextFormField(
                controller: controller.size,
                decoration: const InputDecoration(labelText: 'Product Size'),
              ),
              DropdownButtonFormField(
                value: controller.type.text.isNotEmpty
                    ? controller.type.text
                    : null,
                decoration: const InputDecoration(labelText: 'Product Type'),
                items: <String>['top', 'bottom', 'shoe']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  controller.type.value =
                      TextEditingValue(text: newValue.toString());
                },
              ),
              Obx(() {
                return controller.inputImageUrl.value != ''
                    ? Image.network(
                        controller.inputImageUrl.value,
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      )
                    : Container();
              }),
              Obx(() {
                return ElevatedButton(
                  onPressed:
                      controller.loading.value ? null : controller.uploadImage,
                  child: controller.loading.value
                      ? const CircularProgressIndicator()
                      : const Text('Upload Image'),
                );
              }),
              ElevatedButton(
                onPressed: () {
                  controller.updateProduct();
                  Get.off(HomeScreen());
                },
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
