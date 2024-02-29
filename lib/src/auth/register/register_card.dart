
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../../widgets/inputfield.dart';
import 'register_controller.dart';

final RegisterController controller = Get.find<RegisterController>();

class RegisterCard extends StatelessWidget {
  const RegisterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Get.height * 0.7,
        width: Get.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes x,y position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InputField(
              name: 'Email',
              controller: controller.email,
              labelText: 'Enter Email',
              icon: const Icon(Icons.email_outlined),
            ),
            InputField(
              name: 'Password',
              controller: controller.password,
              labelText: 'Enter Password',
              obscureText: true,
              icon: const Icon(Icons.lock_outline_sharp),
            ),
            InputField(
              name: 'Name',
              controller: controller.name,
              labelText: 'Enter Name',
              icon: const Icon(Icons.person_outline_outlined),
            ),
            
            InputField(
              labelText: 'Enter Phone Number',
              controller: controller.phoneNumber,
              name: 'Phone Number',
              icon: const Icon(Icons.phone_outlined),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(13, 41, 71, 1)),
              onPressed: () async {
                controller.signUp();
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
