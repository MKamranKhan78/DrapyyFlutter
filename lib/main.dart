import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'activities/SplashScreen.dart';

void main() {
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

