import 'package:drapyy/helper/SizeConstants.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/FontsConstants.dart';
import '../helper/drawables.dart';



class RegisterActivity extends StatefulWidget {
  const RegisterActivity({super.key});

  @override
  State<RegisterActivity> createState() => _RegisterActivityState();
}

class _RegisterActivityState extends State<RegisterActivity> {
  bool isLoading = false;
  bool rememberMe = false;
  bool obscurePassword = true;
  bool cobscurePassword = true;
  String? gender; // can be "male", "female", or null

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontFamily: "Gotham Pro",
                      fontSize: 18,
                       fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "IF YOU ALREADY HAVE AN ACCOUNT REGISTER",
                    style: TextStyle(
                      fontFamily: "Gotham Pro",
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,

                    ),
                  ),

                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(
                      "YOU CAN",
                      style: TextStyle(
                        fontFamily: "Gotham Pro",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "LOGIN HERE",
                      style: TextStyle(
                        fontFamily: "Gotham Pro",
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],),

                  /// Email field
                  TextField(
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
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

                  /// Username field
                  TextField(
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                     keyboardType: TextInputType.text, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "ENTER YOUR USERNAME",
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

                  /// Confirm Password field
                  TextField(
                    obscureText: cobscurePassword,
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    decoration: InputDecoration(
                      labelText: "CONFIRM YOUR PASSWORD",
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
                          cobscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            cobscurePassword = !cobscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  /// Date of birth field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "DATE OF BIRTH",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// postalcode field
                  TextField(
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.number, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "POSTAL CODE",
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
                   const SizedBox(height: 10),

                  /// mobile field
                  TextField(
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.phone, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "MOBILE NUMBER",
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
                  const SizedBox(height: 10),

                  /// address field
                  TextField(
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.text, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "ENTER ADDRESS",
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

                  //male female radios buttons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Gender",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 20),

                      /// Male option
                      Row(
                        children: [
                          Radio<String>(
                            value: "male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                            activeColor: Colors.black, // ✅ filled with black when selected
                            fillColor: MaterialStateProperty.all(Colors.black),
                          ),
                          const Text(
                            "Male",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),

                      /// Female option
                      Row(
                        children: [
                          Radio<String>(
                            value: "female",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                            activeColor: Colors.black,
                            fillColor: MaterialStateProperty.all(Colors.black),
                          ),
                          const Text(
                            "Female",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// SIGNUP Button (Rectangular, no rounded corners)
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
                        "SIGN UP",
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
                    children: const [
                      Text(
                        "ALREADY HAVE AN ACCOUNT?",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "SIGN IN",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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