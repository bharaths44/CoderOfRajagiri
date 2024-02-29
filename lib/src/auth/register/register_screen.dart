import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/bg_image.dart';
import 'register_card.dart';
import 'register_controller.dart';

final RegisterController controller = Get.find<RegisterController>();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Get.theme.primaryTextTheme.titleLarge
            ?.color, // Use theme's primary text color
        elevation: 0.0,
        forceMaterialTransparency: true,
        title: const Text('Register'),
      ),
      body: const Stack(
          alignment: Alignment.center, children: [BgImage(), RegisterCard()]),
    );
  }
}
