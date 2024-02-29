import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bg_image.dart';
import 'login_card.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[200],
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BgImage(),
          LoginCard(),
        ],
      ),
    );
  }
}
