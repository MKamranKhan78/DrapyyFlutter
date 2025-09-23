
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

//SEARCH_ABOUT_NAVIGATION
class NavigationHelper {
  /// Navigate to a new screen (keeps previous in stack)
  static void moveToNewScreenAndPreviousSave(Widget page) {
    Get.to(() => page);
  }

  /// Navigate to a new screen and finish the previous one
  static void moveToNewScreenAndPreviousRevome(Widget page) {
    Get.off(() => page);
  }

  /// Navigate to a new screen and clear the entire navigation stack
  static void moveToNewScreenAndPreviousRevomeAll(Widget page) {
    Get.offAll(() => page);
  }

  /// Navigate back to the previous screen
  static void moveToBackScreen() {
    Get.back();
  }

  /// Navigate with arguments
  static void moveToNextScreenWithArgument(Widget page, {dynamic arguments}) {
    Get.to(() => page, arguments: arguments);
  }

  /// Navigate to a new screen and wait for a result
  static Future<T?> moveToNextScreenForResult<T>(Widget page) async {
    return Get.to<T>(() => page);
  }


}
