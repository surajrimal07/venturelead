import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AppBarController extends GetxController {
  final RxBool showSearch = false.obs;
  final RxBool showBack = false.obs;

  setShowSearch(bool isSearchVisible) {
    showSearch(isSearchVisible);
  }

  setShowBack(bool isBackVisible) {
    showBack(isBackVisible);
  }
}
