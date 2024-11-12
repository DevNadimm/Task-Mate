import 'package:get/get.dart';

class BottomNavController extends GetxController {
  static BottomNavController instance = Get.find<BottomNavController>();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int newIndex) {
    _currentIndex = newIndex;
    update();
  }
}
