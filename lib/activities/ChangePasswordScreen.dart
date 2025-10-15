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

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isLoading = false;

  final TextEditingController passwordController = TextEditingController();
  bool passObscurePassword = true;
  final TextEditingController confirmPasswordController = TextEditingController();
  bool confirmObscurePassword = true;
  final TextEditingController newPasswordController = TextEditingController();
  bool newPassObscurePassword = true;




  /// ✅ Validation method
  bool _validateInputs() {
    if (passwordController.text.trim().isEmpty) {
      _showError("Please enter password");
      return false;
    } else if (confirmPasswordController.text.trim().isEmpty) {
      _showError("Please new password");
      return false;
    } else if (newPasswordController.text.trim().isEmpty) {
      _showError("Please confirm password");
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
                    "CHANGE PASSWORD",
                    style: TextStyle(
                      fontFamily: "Gotham Pro",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),


                  /// Password field
                  TextField(
                    controller: passwordController,
                    obscureText: passObscurePassword,
                    decoration: InputDecoration(
                      labelText: "ENTER YOUR PASSWORD",
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passObscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            passObscurePassword = !passObscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Confirm Password field
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: confirmObscurePassword,
                    decoration: InputDecoration(
                      labelText: "ENTER NEW PASSWORD",
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          confirmObscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            confirmObscurePassword = !confirmObscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Confirm Password field
                  TextField(
                    controller: newPasswordController,
                    obscureText: newPassObscurePassword,
                    decoration: InputDecoration(
                      labelText: "CONFIRM YOUR PASSWORD",
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          newPassObscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            newPassObscurePassword = !newPassObscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  /// SIGN UP Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateInputs()) {
                          changePassword(
                            passwordController.text.trim(),
                            confirmPasswordController.text.trim(),
                            newPasswordController.text.trim()
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
                        "CHANGE PASSWORD",
                        style: TextStyle(
                          fontFamily: "Gotham Pro",
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

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
  Future<void> changePassword(
      String password,
      String newPassword,
      String confirmPassword,
      ) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.update_password);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };
    final requestBody = {
      "old_password": password.toString(),
      "password": newPassword.toString(),
      "password_confirmation": confirmPassword.toString(),
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
          Get.back(result: "Reload Address");
          Get.snackbar(
            "Status ${model.status}",
            model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2),
          );
        });



      } else if (model.status == 0) {
        Get.snackbar(
          "Status ${model.status}",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Status ${model.status}",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Status ${model.status}",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
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
