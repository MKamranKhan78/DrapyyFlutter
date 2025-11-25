import 'dart:convert';

import 'package:drapyy/activities/ForgotPasswordActivity.dart';
import 'package:drapyy/activities/MainActivity.dart';
import 'package:drapyy/activities/RegisterActivity.dart';
import 'package:drapyy/helper/SizeConstants.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../helper/FontsConstants.dart';
import '../helper/NavigationHelper.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/drawables.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
     super.initState();
    // login("kamrank@gmail.com", "Password@1");
  }



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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress, // ✅ email input
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
                    controller: passwordController,
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
                          Get.to(() => const ForgotPasswordActivity());

                        },
                        child: Text(
                          "FORGOT PASSWORD?",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 11,
                            color: Colors.black,
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

                        print("PRINT-1--->");
                        if (_validateInputs()) {
                          login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        }

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
                          Get.to(() => const RegisterActivity());

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


  bool _validateInputs() {
    print("PRINT-2--->");
    if (emailController.text.trim().isEmpty ||
        !RegExp(
          r"^[\w\.-]+@[\w\.-]+\.\w+$",
        ).hasMatch(emailController.text.trim())) {
      print("PRINT-3--->");
      _showError("Please enter a valid email address");
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      print("PRINT-4--->");
      _showError("Please enter password");
      return false;
    }
    return true;
  }

  void _showError(String message) {
    print("PRINT-5--->");
    Get.snackbar(
      "Validation Error",
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
  }


  Future<void> login(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.login);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {
      "email": email,
      "password": password,
    };

    final client = CustomHttpClient(http.Client());

    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print('POST URL: $url');
      print('Request Headers: $headers');
      print('Request Body: ${jsonEncode(requestBody)}');
      print('Response Code: ${response.statusCode}');
      print("-------------------------------------FULL RESPONSE-------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");
      final model = LoginResponseModel.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          Get.snackbar(
            "Login",
            model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2),
          );


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


        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Login",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Login",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Login",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Login",
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
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