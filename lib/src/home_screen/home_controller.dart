import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxInt tabIndex = 0.obs;
  changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  initTabIndex() {
    tabIndex.value = 0;
  }
}
