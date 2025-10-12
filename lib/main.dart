import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'activities/SplashScreen.dart';



/*const firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyBifQkR3bs3h8ntIDjgEZPG8ERBdSUIusI",
  appId: "1:484396006856:android:bdc0dec1a6d505805e14fd",
  messagingSenderId: "484396006856",
  projectId: "videochat-8f94b",
);*/

Future<void> main() async {

  /*WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter framework is initialized
  try {
    await Firebase.initializeApp(options: firebaseOptions); // Initialize Firebase
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      print('Firebase app already initialized');
    } else {
      rethrow; // Rethrow if it's a different error
    }
  }*/

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Color.fromRGBO(0, 34, 74, 1)),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          dividerColor: Color.fromRGBO(0, 34, 74, 1),
          headerBackgroundColor: Color.fromRGBO(0, 34, 74, 1),
          headerForegroundColor: Colors.white,
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

