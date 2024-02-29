import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late NavigatorState navigator;

  @override
  void initState() {
    super.initState();
    navigator = Navigator.of(context); // Store the Navigator instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        backgroundColor: Get.theme.primaryColor, // Use theme's primary color
        foregroundColor: Get.theme.primaryTextTheme.titleLarge
            ?.color, // Use theme's primary text color
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            snapshot.data!.reload(); // Reload the user
            if (snapshot.data!.emailVerified) {
              // If the email is verified, navigate to the login page
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.snackbar(
                  'Success', // title
                  'Successfully Verified', // message
                  snackPosition: SnackPosition.BOTTOM,
                );
                navigator.pushNamedAndRemoveUntil('/login/', (route) => false);
              });
            }
          }
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Please verify your email',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                    },
                    child: const Text(
                      'Send email verification',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          );
        },
      ),
    );
  }
}
