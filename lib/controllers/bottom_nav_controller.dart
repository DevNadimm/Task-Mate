import 'package:get/get.dart';

class BottomNavController extends GetxController {
  static BottomNavController instance = Get.find<BottomNavController>();

  int currentIndex = 0;

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    update();
  }
}
