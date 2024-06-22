import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AppBarController extends GetxController {
  var showSearch = false.obs;
  var showBack = false.obs;
  var showShare = false.obs;
  var showNotificationIcon = true.obs;
  var showSettings = false.obs;
  var showBookmark = true.obs;
  var showCustomText = false.obs;
  var customText = ''.obs;

  setShowSearch(bool isSearchVisible) {
    showSearch(isSearchVisible);
  }

  setShowSettings(bool isSearchVisible) {
    showSettings(isSearchVisible);
  }

  setShowBack(bool isBackVisible) {
    showBack(isBackVisible);
  }

  setShowShare(bool isShareVisible) {
    showShare(isShareVisible);
  }

  setShowBookmark(bool isBookmarkVisible) {
    showBookmark(isBookmarkVisible);
  }

  setShowCustomText(bool isCustomTextVisible) {
    showCustomText(isCustomTextVisible);
  }

  setCustomText(String text) {
    customText(text);
  }

  setShowNotificationIcon(bool isNotificationIconVisible) {
    showNotificationIcon(isNotificationIconVisible);
  }
}
