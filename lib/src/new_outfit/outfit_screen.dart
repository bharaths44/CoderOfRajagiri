import 'package:cor/src/new_outfit/outfit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutfitShuffle extends StatelessWidget {
  final WardrobeController controller = Get.put(WardrobeController());

  OutfitShuffle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.selectedTop.value == null &&
            controller.selectedBottom.value == null) {
          return Center(
            child: ElevatedButton(
              onPressed: controller.shuffleOutfit,
              child: const Text('Create New Outfit'),
            ),
          );
        } else {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  if (controller.selectedTop.value != null) {
                    return Column(
                      children: [
                        Text(
                          controller.selectedTop.value!.name,
                          style: Get.theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            controller.selectedTop.value!.image,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                Obx(() {
                  if (controller.selectedBottom.value != null) {
                    return Column(
                      children: [
                        Text(
                          controller.selectedBottom.value!.name,
                          style: Get.theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            controller.selectedBottom.value!.image,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                Obx(() {
                  if (controller.selectedShoe.value != null) {
                    return Column(
                      children: [
                        Text(
                          controller.selectedShoe.value!.name,
                          style: Get.theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            controller.selectedShoe.value!.image,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ],
            ),
          );
        }
      }),
      floatingActionButton: Obx(() {
        if (controller.selectedTop.value != null ||
            controller.selectedBottom.value != null ||
            controller.selectedShoe.value != null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: controller.shuffleOutfit,
                heroTag: 'shuffleButton',
                child: const Icon(Icons.shuffle),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: controller.saveOutfit,
                heroTag: 'saveButton',
                child: const Icon(Icons.save),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
