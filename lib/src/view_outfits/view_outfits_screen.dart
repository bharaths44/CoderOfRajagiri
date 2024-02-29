import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view_outfits_controller.dart';

class ViewOutfitScreen extends StatelessWidget {
  final ViewOutfitController controller = Get.put(ViewOutfitController());

  ViewOutfitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.outfits.isEmpty) {
          return const Center(child: Text('No outfit generated'));
        } else {
          return ListView.builder(
            itemCount: controller.outfits.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: Future.wait([
                  controller.fetchTopImage(controller.outfits[index]),
                  controller.fetchBottomImage(controller.outfits[index]),
                  controller.fetchShoeImage(controller.outfits[index]),
                ]),
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data != null) {
                    return Stack(
                      children: [
                        Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text('Outfit  ${index + 1}',
                                      style: Get.theme.textTheme.titleLarge),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child:
                                              Image.network(snapshot.data![0])),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child:
                                              Image.network(snapshot.data![1])),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child:
                                              Image.network(snapshot.data![2]))
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 15,
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await controller.removeOutfit(
                                  controller.outfits[index].docId);
                              controller.outfits.removeAt(index);
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          );
        }
      }),
    );
  }
}
