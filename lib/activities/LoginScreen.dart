import 'package:drapyy/helper/SizeConstants.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/FontsConstants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  String email = "no eamil send";
  String isGuest = "no value send";



  @override
  void initState() {
    super.initState();
    final args = Get.arguments; // 👈 contains the passed map
    if(args !=null){
      if(args?['email'] != null){
        email = args?['email'];
      }
      if(args!['isGuest'] != null){
        isGuest = args!['isGuest'].toString();
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //SEARCH_ABOUT_NAVIGATION
            /*InkWell(
              onTap: (){
                Get.back(result: "Hello from Screen B");
              },
              child: Text(
                  'click to send data to previous screen-email and is guest values are ---->$email--$isGuest',
                  style:TextStyle(
                    fontFamily: FontConstants.tektonPro,
                    fontSize: SizeConstants.fontSize16,
                    fontWeight: FontWeight.w700,
                    color: app_color_black
                  )
              ),
            ),*/


          ],
        ),
      ),
    );
  }
}