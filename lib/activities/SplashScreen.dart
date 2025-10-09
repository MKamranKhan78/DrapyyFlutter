import 'dart:convert';

import 'package:drapyy/activities/AccountInformationScreen.dart';
import 'package:drapyy/activities/ForgotPasswordActivity.dart';
import 'package:drapyy/activities/MainActivity.dart';
import 'package:drapyy/activities/RegisterActivity.dart';
import 'package:drapyy/fragments/ProfileFragment.dart';
import 'package:drapyy/helper/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../helper/NavigationHelper.dart';
import '../helper/colors.dart';
import '../helper/customHttpClient.dart';
import '../helper/drawables.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';
import 'LoginScreen.dart';



class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    _initializeApp();
    guestSignup();
  }

  /// Combines initialization tasks
  Future<void> _initializeApp() async {
    try {
      await PreferenceManager.init();
      await _navigateToNextScreen();
    } catch (e, stackTrace) {
       print("Initialization Error: $e");
     }
  }

  /// Handles navigation logic
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));


    //SEARCH_ABOUT_NAVIGATION
    //---------------------------------------------
    // it will never finish the previous screen.
    //NavigationHelper.moveToNewScreenAndPreviousSave(LoginScreen());
    //--------------------------------------------------------------
    // it will finish previous screen.
    NavigationHelper.moveToNewScreenAndPreviousRevome(LoginScreen());
    //NavigationHelper.moveToNewScreenAndPreviousRevome(AccountInformationScreen());
    //--------------------------------------------------------------
    //send value to next screen.
    // NavigationHelper.moveToNextScreenWithArgument(
    //   const LoginScreen(),
    //   arguments: {"email": "test@example.com", "isGuest": true},
    // );
    //---------------------------------------------------------------
    // Navigate to Screen B and wait for a result
    // final result = await NavigationHelper.moveToNextScreenForResult<String>(LoginScreen());
    // if (result != null) {
    //   print("Got value from Screen B: $result");
    // }
    //----------------------------------------------------------------




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Image.asset(
          Drawables.img_logo,
          height: 224,
          width: 300,
        ),
      ),
    );
  }



  Future<void> guestSignup() async {
    setState(() {
      isLoading = true;
    });
    final url =
    Uri.parse(NetworkManager.BASE_URL + NetworkManager.guest_api);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final requestBody = {
      "device_token": "hdhfgjhreuyiueyrtuyenyriuuomjdn-Ahdjfrr",
    };
    final client = CustomHttpClient(http.Client());
    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      print('POST URL: $url');
      print('Request Body: ${jsonEncode(requestBody)}');
      print('Response Code: ${response.statusCode}');
      print("-------------------------------------FULL RESPONSE------------------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");
      final model = GuestResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {

           PreferenceManager.setString(NetworkManager.API_TOKEN, "Bearer ${model.data?.accessToken.toString()}");
           PreferenceManager.setString(NetworkManager.PREF_CUSTOMER_ID, model.data!.user!.id.toString());

          Get.snackbar(
            "Status "+model.status.toString(),
            model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: EdgeInsets.all(10),
            duration: Duration(seconds: 2),
          );
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Status "+model.status.toString(),
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Status "+model.status.toString(),
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Status "+model.status.toString(),
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
       Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


}

