import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/customappbar.dart';
import 'add_clothes_controller.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductController>(
      init: AddProductController(),
      dispose: (_) {
        Get.delete<AddProductController>();
      },
      builder: (controller) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Add Product',
            leading: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: controller.name,
                    decoration:
                        const InputDecoration(labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: controller.brand,
                    decoration:
                        const InputDecoration(labelText: 'Brand of dress'),
                  ),
                  TextField(
                    controller: controller.color,
                    decoration:
                        const InputDecoration(labelText: 'Product color'),
                  ),
                  TextField(
                    controller: controller.size,
                    decoration:
                        const InputDecoration(labelText: 'Product size'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        title: const AutoSizeText('Top', maxLines: 1),
                        leading: Obx(() => Radio<String>(
                              value: 'top',
                              groupValue: controller.type.value,
                              onChanged: (String? value) {
                                controller.type.value = value!;
                              },
                            )),
                      ),
                      ListTile(
                        title: const AutoSizeText('Bottom', maxLines: 1),
                        leading: Obx(() => Radio<String>(
                              value: 'bottom',
                              groupValue: controller.type.value,
                              onChanged: (String? value) {
                                controller.type.value = value!;
                              },
                            )),
                      ),
                      ListTile(
                        title: const AutoSizeText('Shoe', maxLines: 1),
                        leading: Obx(() => Radio<String>(
                              value: 'shoe',
                              groupValue: controller.type.value,
                              onChanged: (String? value) {
                                controller.type.value = value!;
                              },
                            )),
                      ),
                    ],
                  ),
                  Obx(() {
                    return controller.image.value != null
                        ? Image.file(
                            controller.image.value!,
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                          )
                        : Container(
                            height: 100,
                          );
                  }),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: controller.loading.value
                          ? null
                          : controller.uploadImage,
                      child: controller.loading.value
                          ? const CircularProgressIndicator()
                          : Text(controller.image.value != null
                              ? 'Change Image'
                              : 'Upload Image'),
                    );
                  }),
                  ElevatedButton(
                    onPressed: () {
                      controller.addProduct();
                    },
                    child: const Text('Add Product'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
