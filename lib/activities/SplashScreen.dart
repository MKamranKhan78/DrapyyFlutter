import 'dart:convert';

import 'package:drapyy/activities/AccountInformationScreen.dart';
import 'package:drapyy/activities/ForgotPasswordActivity.dart';
import 'package:drapyy/activities/MainActivity.dart';
import 'package:drapyy/activities/OnboardingScreen.dart';
import 'package:drapyy/activities/RegisterActivity.dart';
import 'package:drapyy/fragments/ProfileFragment.dart';
import 'package:drapyy/helper/ToastUtils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../fragments/HomeFragment.dart';
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
  }

  Future<void> checkGuestStatus() async {
    print("SPLASH_checkGuestStatus------------>");
    final isGuest = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST)?.toString() ?? "";
    if (isGuest.isNotEmpty) {
      print("SPLASH_checkGuestStatus------------1>-------isGuest--->"+isGuest.toString());
       if (isGuest == "0") {
        print("SPLASH_checkGuestStatus------------2>");
        Get.offAll(() => MainActivity());
        //Get.offAll(() => Onboardingscreen());
      } else {
        print("SPLASH_checkGuestStatus------------3>");
        guestSignup("sdhfjdshfjhsd j fhdsjgf hsgdhfgshdghf gdshgf hsdg fsd");
      }
    } else {
      print("checkGuestStatus------------4>");
      guestSignup("SPLASH_sdhfjdshfjhsd j fhdsjgf hsgdhfgshdghf gdshgf hsdg fsd");
    }
  }

  /// Combines initialization tasks
  Future<void> _initializeApp() async {
    try {
      await PreferenceManager.init();
      await checkGuestStatus();
    } catch (e, stackTrace) {
       print("Initialization Error: $e");
     }
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



  Future<void> guestSignup(String deviceToken) async {
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
      "device_token": deviceToken.toString(),
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
           PreferenceManager.setString(NetworkManager.PREF_IS_GUEST, model.data!.user!.isGuest.toString());
           PreferenceManager.setString(NetworkManager.PREF_EMAIL, model.data!.user?.email ?? "");
           PreferenceManager.setString(NetworkManager.PREF_MOBILE, model.data!.user?.phoneNo ?? "");
           PreferenceManager.setString(NetworkManager.PREF_FULL_NAME, model.data!.user?.name ?? "");
           PreferenceManager.setString(NetworkManager.PREF_USER_ID, model.data!.user!.id.toString());
           PreferenceManager.setString(NetworkManager.PREF_CITY_NAME, model.data!.user?.city ?? "");
           PreferenceManager.setString(NetworkManager.PREF_DOB_NAME, model.data!.user?.dateOfBirth ?? "");
           PreferenceManager.setString(NetworkManager.PREF_ADRESS, model.data!.user?.address ?? "");
           PreferenceManager.setString(NetworkManager.PREF_POSTAL_CODE, model.data!.user?.postalCode ?? "");
           Get.offAll(() => MainActivity());
           //Get.offAll(() => Onboardingscreen());


        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Guest",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Guest",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Guest",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
       Get.snackbar(
         "Guest",
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

