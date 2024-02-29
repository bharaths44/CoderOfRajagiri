import 'package:cor/core/dependency.dart';
import 'package:cor/src/add_clothes/add_product.dart';
import 'package:cor/src/home_screen/home_screen.dart';

import 'package:cor/src/view_clothes/all_products.dart';

import 'package:cor/texttheme.dart';
import 'package:cor/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'src/auth/forgot_password/forgot_password_screen.dart';
import 'src/auth/login/login_screen.dart';
import 'src/auth/register/register_screen.dart';
import 'src/auth/verify_email/verify_email_view.dart';
import 'src/view_clothes/details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyCreator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: textTheme),
      routes: {
        '/allProductScreen/': (context) => AllProductScreen(),
        '/login/': (context) => LoginScreen(),
        '/verifyemail/': (context) => const VerifyEmailView(),
        '/forgot_password/': (context) => const ForgotPassWordScreen(),
        '/addProductScreen': (context) => AddProductScreen(),
        '/register/': (context) => const RegisterScreen(),
        '/detailScreen/': (context) => const DetailsScreen(),
        '/home/': (context) => HomeScreen(),
      },
      initialBinding: DashBoardControllerBinding(),
      home: LoginScreen(),
    );
  }
}
