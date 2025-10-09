import 'dart:convert';

import 'package:drapyy/helper/SizeConstants.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/drawables.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';



class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isLoading = false;
  String? selectedValueCity;

  final List<String> cityList = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

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
                    "Add Address",
                    style: TextStyle(
                      fontFamily: "Gotham Pro",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  /// Username field
                  TextField(
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.text, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "ENTER NAME",
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

                  const SizedBox(height: 20),
                  TextField(
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.text, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "ADDRESS",
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
                  TextField(
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.text, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "BILLING ADDRESS",
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



                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedValueCity,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                      hint: const Text(
                        "Select City",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      items: cityList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedValueCity = newValue;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 50),



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
                        "ADD ADDRESS",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
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


  Future<void> addAddress(
      String name,
      String phone_no,
      String address,
      String billing_address,
      String city,
      String is_default,
      ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.addAddress);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "name": name.toString(),
      "phone_no": phone_no.toString(),
      "address": address.toString(),
      "billing_address": billing_address.toString(),
      "city": city.toString(),
      "is_default": is_default.toString(),
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
          "-------------------------------------FULL RESPONSE-------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print(
          "-------------------------------------------------------------------------------------");

      final model =
      PlaceOrderResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        Get.snackbar(
          "Status ${model.status}",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
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
          "Error",
          "Unexpected response from server.",
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


  Future<void> updateAddress(
      String name,
      String phone_no,
      String address,
      String billing_address,
      String city,
      String is_default,
      ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.addressUpdate);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "name": name.toString(),
      "phone_no": phone_no.toString(),
      "address": address.toString(),
      "billing_address": billing_address.toString(),
      "city": city.toString(),
      "is_default": is_default.toString(),
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
          "-------------------------------------FULL RESPONSE-------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print(
          "-------------------------------------------------------------------------------------");

      final model =
      PlaceOrderResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        Get.snackbar(
          "Status ${model.status}",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
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
          "Error",
          "Unexpected response from server.",
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