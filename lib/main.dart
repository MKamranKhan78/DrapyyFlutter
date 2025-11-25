import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'activities/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => Overlay(
        initialEntries: [
          OverlayEntry(builder: (context) => child!),
        ],
      ),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(0, 34, 74, 1),
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}