import 'package:cor/src/view_clothes/all_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/model/item_model.dart';
import '../update_clothes/update_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments;
    AllProductsController controller = Get.find<AllProductsController>();
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          product.name,
                          style: Get.theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Brand: ${product.brand}',
                        style: Get.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          //color: Get.theme.accentColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Size: ${product.size}',
                        style: Get.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Color: ${product.color}',
                        style: Get.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Type : ${product.type}',
                        style: Get.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'editButton',
              child: const Icon(Icons.edit),
              onPressed: () {
                Get.to(() => UpdateProductScreen(), arguments: product);
              },
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              child: const Icon(Icons.delete),
              onPressed: () async {
                await controller.deleteProduct(product);
              },
            ),
          ],
        ));
  }
}
