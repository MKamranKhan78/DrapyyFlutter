import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'colors.dart';

class Toastutils {
     static void showToast(String message) {
       Get.snackbar(backgroundColor: Colors.black,colorText: Colors.white,'Error', message);
     }


  static void showSnackbar(String title,String message) {
    Get.snackbar(
      title,              // first parameter: title
      message,            // second parameter: message
      backgroundColor: Colors.black,
      colorText: Colors.white,
      //snackPosition: SnackPosition.BOTTOM, // optional
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 2),
    );
  }


}
