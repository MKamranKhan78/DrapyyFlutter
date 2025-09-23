import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/NavigationHelper.dart';
import '../helper/colors.dart';
import '../helper/drawables.dart';
import '../helper/preference_manager.dart';
import 'LoginScreen.dart';



class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
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
          Drawables.splashLogo,
          height: 224,
          width: 300,
        ),
      ),
    );
  }
}

