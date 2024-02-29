import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/model/item_model.dart';
import 'all_product_controller.dart';

class AllProductScreen extends StatelessWidget {
  final AllProductsController allProductsController =
      Get.put<AllProductsController>(AllProductsController());

  AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Top'),
                Tab(text: 'Bottom'),
                Tab(text: 'Shoes'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() {
              if (allProductsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (allProductsController.products.isEmpty) {
                return const Center(child: Text('Nothing found'));
              } else {
                return buildProductGrid(allProductsController.products);
              }
            }),
            Obx(() {
              var topProducts = allProductsController.products
                  .where((product) => product.type == 'top')
                  .toList();
              if (allProductsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (topProducts.isEmpty) {
                return const Center(child: Text('Nothing found'));
              } else {
                return buildProductGrid(topProducts);
              }
            }),
            Obx(() {
              var bottomProducts = allProductsController.products
                  .where((product) => product.type == 'bottom')
                  .toList();
              if (allProductsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (bottomProducts.isEmpty) {
                return const Center(child: Text('Nothing found'));
              } else {
                return buildProductGrid(bottomProducts);
              }
            }),
            Obx(() {
              var shoeProducts = allProductsController.products
                  .where((product) => product.type == 'shoe')
                  .toList();
              if (allProductsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (shoeProducts.isEmpty) {
                return const Center(child: Text('Nothing found'));
              } else {
                return buildProductGrid(shoeProducts);
              }
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Product',
          onPressed: () {
            Get.toNamed('/addProductScreen');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildProductGrid(List<Product> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];
        return GestureDetector(
          onTap: () {
            Get.toNamed('/detailScreen/', arguments: product);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: GridTile(
              footer: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.black54,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Name: ${product.name}\nBrand: ${product.brand}\nSize: ${product.size}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  product.image,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
