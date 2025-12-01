import 'dart:convert';
import 'package:drapyy/activities/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';


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
  String? gender;
  DateTime? selectedDate;

  // ✅ TextEditingControllers for all fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  //final TextEditingController postalCodeController = TextEditingController();
  //final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  /// ✅ Date picker for DOB
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  /// ✅ Validation method
  bool _validateInputs() {
    if (nameController.text.trim().isEmpty) {
      _showError("Please enter your full name");
      return false;
    } else if (emailController.text.trim().isEmpty ||
        !RegExp(
          r"^[\w\.-]+@[\w\.-]+\.\w+$",
        ).hasMatch(emailController.text.trim())) {
      _showError("Please enter a valid email address");
      return false;
    } else if (usernameController.text.trim().isEmpty) {
      _showError("Please enter username");
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      _showError("Please enter password");
      return false;
    } else if (confirmPasswordController.text.trim().isEmpty) {
      _showError("Please confirm your password");
      return false;
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      _showError("Passwords do not match");
      return false;
    } else if (selectedDate == null) {
      _showError("Please select date of birth");
      return false;
    }
    /* else if (postalCodeController.text.trim().isEmpty ||
        !RegExp(r"^\d+$").hasMatch(postalCodeController.text.trim())) {
      _showError("Please enter a valid postal code");
      return false;
    }*/
    else if (mobileController.text.trim().isEmpty ||
        !RegExp(r"^[0-9]+$").hasMatch(mobileController.text.trim())) {
      _showError("Please enter a valid mobile number (only digits)");
      return false;
    }
    /* else if (addressController.text.trim().isEmpty) {
      _showError("Please enter your address");
      return false;
    }*/
    else if (countryController.text.trim().isEmpty) {
      _showError("Please enter country");
      return false;
    } else if (gender == null) {
      _showError("Please select gender");
      return false;
    }
    return true;
  }

  void _showError(String message) {
    Get.snackbar(
      "Validation Error",
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new, size: 20),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontFamily: "Gotham Pro",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
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
                    children: const [
                      Text(
                        "YOU CAN",
                        style: TextStyle(
                          fontFamily: "Gotham Pro",
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "LOGIN HERE",
                        style: TextStyle(
                          fontFamily: "Gotham Pro",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// Full Name
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: "FULL NAME",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Email field
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "EMAIL ADDRESS",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Username field
                  TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "ENTER YOUR USERNAME",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Password field
                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: "ENTER YOUR PASSWORD",
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
                    controller: confirmPasswordController,
                    obscureText: cobscurePassword,
                    decoration: InputDecoration(
                      labelText: "CONFIRM YOUR PASSWORD",
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

                  /// Date of Birth Picker
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedDate == null
                              ? "DATE OF BIRTH"
                              : "${DateFormat('dd-MM-yyyy').format(selectedDate!)}",
                          style: const TextStyle(
                            fontFamily: "Gotham Pro",
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(color: Colors.black, thickness: 1),
                      ],
                    ),
                  ),


                  /* const SizedBox(height: 10),

                  /// Postal Code
                  TextField(
                    controller: postalCodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "POSTAL CODE",
                      border: UnderlineInputBorder(),
                    ),
                  ),*/


                  const SizedBox(height: 10),
                  /// Mobile Number
                  TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "MOBILE NUMBER",
                      border: UnderlineInputBorder(),
                    ),
                  ),


                  /*const SizedBox(height: 10),

                  /// Address
                  TextField(
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                      labelText: "ENTER ADDRESS",
                      border: UnderlineInputBorder(),
                    ),
                  ),*/

                  const SizedBox(height: 10),
                  /// City
                  TextField(
                    controller: countryController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "ENTER COUNTRY",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Gender Selection
                  Row(
                    children: [
                      const Text("Gender", style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Radio<String>(
                            value: "male",
                            groupValue: gender,
                            onChanged:
                                (value) => setState(() => gender = value),
                            activeColor: Colors.black,
                          ),
                          const Text("Male"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "female",
                            groupValue: gender,
                            onChanged:
                                (value) => setState(() => gender = value),
                            activeColor: Colors.black,
                          ),
                          const Text("Female"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// SIGN UP Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateInputs()) {
                          register(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            usernameController.text.trim(),
                            mobileController.text.trim(),
                            //addressController.text.trim(),
                            gender!,
                            DateFormat('dd-MM-yyyy').format(selectedDate!),
                            countryController.text.trim(),
                            //postalCodeController.text.trim(),
                            passwordController.text.trim(),
                            confirmPasswordController.text.trim(),
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
                        "SIGN UP",
                        style: TextStyle(
                          fontFamily: "Gotham Pro",
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "ALREADY HAVE AN ACCOUNT?",
                        style: TextStyle(
                          fontFamily: "Gotham Pro",
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: (){
                          Get.to(const LoginScreen());
                        },
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                            fontFamily: "Gotham Pro",
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

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

  /// ✅ Your original register() method remains untouched
  Future<void> register(
      String name,
      String email,
      String username,
      String phone_no,
      //String address,
      String gender_,
      String date_of_birth,
      String country,//city,
      //String postal_code,
      String password,
      String password_confirmation,
      ) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.register);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };
    final requestBody = {
      "name": name,
      "email": email,
      "username": username,
      "phone_no": phone_no,
      //"address": address,
      "gender": gender_,
      "date_of_birth": date_of_birth,
      //"city": city,
      "country": country,
      //"postal_code": postal_code,
      "newsletter": 1,
      "privacy_and_policy": 1,
      "password": password,
      "password_confirmation": password_confirmation,
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
      print(
        "-------------------------------------FULL RESPONSE-------------------------------------",
      );
      Toastutils.printFullText(response.body.toString());
      print(
        "-------------------------------------------------------------------------------------",
      );
      final model = RegistrationModel.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          Get.snackbar(
            "Register",
            model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2),
          );
        });

        Get.offAll(() => LoginScreen());


      } else if (model.status == 0) {
        Get.snackbar(
          "Register",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Register",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Register",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Register",
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
