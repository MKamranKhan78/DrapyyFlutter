import 'package:drapyy/activities/RegisterActivity.dart';
import 'package:drapyy/helper/SizeConstants.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/FontsConstants.dart';
import '../helper/NavigationHelper.dart';
import '../helper/drawables.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//
//
//   String email = "no eamil send";
//   String isGuest = "no value send";
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments; // 👈 contains the passed map
//     if(args !=null){
//       if(args?['email'] != null){
//         email = args?['email'];
//       }
//       if(args!['isGuest'] != null){
//         isGuest = args!['isGuest'].toString();
//       }
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Login Screen")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             //SEARCH_ABOUT_NAVIGATION
//             /*InkWell(
//               onTap: (){
//                 Get.back(result: "Hello from Screen B");
//               },
//               child: Text(
//                   'click to send data to previous screen-email and is guest values are ---->$email--$isGuest',
//                   style:TextStyle(
//                     fontFamily: FontConstants.tektonPro,
//                     fontSize: SizeConstants.fontSize16,
//                     fontWeight: FontWeight.w700,
//                     color: app_color_black
//                   )
//               ),
//             ),*/
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  /// Center Logo
                  Center(
                    child: Image.asset(
                      Drawables.img_logo,
                      height: 200,
                      width: 200,
                    ),
                  ),


                  /// Email field
                  TextField(
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    decoration: const InputDecoration(
                      labelText: "ENTER YOUR EMAIL ADDRESS",
                      labelStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Password field
                  TextField(
                    obscureText: obscurePassword,
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    decoration: InputDecoration(
                      labelText: "ENTER YOUR PASSWORD",
                      labelStyle: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Remember Me + Forgot Password
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        "REMEMBER ME",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 11,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){

                        },
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "FORGOT PASSWORD?",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 11,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Login Button (Rectangular, no rounded corners)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Bottom Sign Up text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "IF YOU DON'T HAVE AN ACCOUNT?",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          NavigationHelper.moveToNewScreenAndPreviousSave(const RegisterActivity());
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// Loading Overlay
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }
}