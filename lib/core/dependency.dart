import 'package:cor/src/view_outfits/view_outfits_controller.dart';
import 'package:get/get.dart';

import '../src/auth/login/login_controller.dart';
import '../src/auth/register/register_controller.dart';
import '../src/home_screen/home_controller.dart';
import '../src/view_clothes/all_product_controller.dart';

class AllProductsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProductsController>(() => AllProductsController(),
        fenix: true);
  }
}

class DashBoardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController(), fenix: true);
  }
}

class RegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}

class ViewOutfitControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewOutfitController>(() => ViewOutfitController());
  }
}

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class DependencyCreator {
  static init() {
    DashBoardControllerBinding().dependencies();
    RegisterControllerBinding().dependencies();
    LoginControllerBinding().dependencies();
    AllProductsControllerBinding().dependencies();
    ViewOutfitControllerBinding().dependencies();
  }
}
