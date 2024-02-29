import 'package:cor/src/home_screen/home_controller.dart';
import 'package:cor/src/home_screen/side_drawer/side_drawer.dart';
import 'package:cor/src/new_outfit/outfit_screen.dart';
import 'package:cor/src/view_clothes/all_products.dart';
import 'package:cor/src/view_outfits/view_outfits_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final DashBoardController controller = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title:
              Text("Wardrobe Manager", style: Get.theme.textTheme.titleLarge),
          forceMaterialTransparency: true,
        ),
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex.value,
            children: [
              AllProductScreen(),
              ViewOutfitScreen(),
              OutfitShuffle(),
            ],
          ),
        ),
        drawer: SideDrawer(),
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.tabIndex.value,
          onDestinationSelected: (index) {
            controller.changeTabIndex(index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag),
              label: "Outfits",
            ),
            NavigationDestination(
              icon: Icon(Icons.shuffle),
              label: "Shuffle",
            ),
          ],
        ),
      );
    });
  }
}
