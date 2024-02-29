
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../../widgets/inputfield.dart';
import '../login/login_controller.dart';

final LoginController controller = Get.put(LoginController());

class ForgotPassWordScreen extends StatelessWidget {
  const ForgotPassWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: Container(
          height: Get.height * 0.3,
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InputField(
                name: 'Email',
                controller: controller.email,
                labelText: 'Enter Email',
                icon: const Icon(Icons.email_outlined),
              ),
              ElevatedButton(
                onPressed: () async {
                  controller.forgotPassword();
                },
                child: const Text('Send Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
