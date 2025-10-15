
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {



  bool isLoading = false;

  String name = "";
  String email = "";
  String address = "";
  String phone = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();



  @override
  void initState() {
    super.initState();
    getProfile();
  }


  String date_of_birth = "";


  // ✅ Function to pick new date
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = date_of_birth.isNotEmpty
        ? DateTime(2000)
        : DateTime(2000); // default if empty

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(), // can’t pick future DOB
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black, // ✅ header color
              onPrimary: Colors.white, // ✅ text color in header
              onSurface: Colors.black, // ✅ body text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        // ✅ format to "dd MMM yyyy"
        date_of_birth = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(), // ✅ centered loader
        )
            : SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 40),

              // Title
              Text(
                "PROFILE UPDATE",
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              // Email
              //_infoRow("EMAIL:", email.toString()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EMAIL:",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        email.toString(),
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.black),

              // Name
              //_infoRow("NAME:", name.toString()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NAME:",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none, // ✅ removes underline
                          enabledBorder: InputBorder.none, // ✅ also remove when enabled
                          focusedBorder: InputBorder.none, // ✅ remove underline on focus
                          isDense: true, // optional: make it more compact
                          contentPadding: EdgeInsets.zero, // optional: remove extra space
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.black),

              // DOB
              //_infoRow("DATE OF BIRTHDAY:", date_of_birth.toString()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "DATE OF BIRTHDAY:",
                      style: TextStyle(
                        fontFamily: 'GothamPro',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context), // ✅ open picker
                        child: Text(
                          date_of_birth.isNotEmpty
                              ? date_of_birth
                              : "Select your date of birth", // placeholder if empty
                          style: const TextStyle(
                            fontFamily: 'GothamPro',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.black),

              // Address
              //_infoRow("ADDRESS:", address.toString()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ADDRESS:",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: addressController,
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none, // ✅ removes underline
                          enabledBorder: InputBorder.none, // ✅ also remove when enabled
                          focusedBorder: InputBorder.none, // ✅ remove underline on focus
                          isDense: true, // optional: make it more compact
                          contentPadding: EdgeInsets.zero, // optional: remove extra space
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.black),

              // Phone
              // _infoRow("PHONE:", phone.toString()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PHONE:",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none, // ✅ removes underline
                          enabledBorder: InputBorder.none, // ✅ also remove when enabled
                          focusedBorder: InputBorder.none, // ✅ remove underline on focus
                          isDense: true, // optional: make it more compact
                          contentPadding: EdgeInsets.zero, // optional: remove extra space
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    updateProfile(
                        nameController.text.toString(),
                        phoneController.text.toString(),
                        addressController.text.toString(),
                        date_of_birth
                    );
                  },
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),


            ],

          ),
        ),
      ),
    );
  }



  Future<void> getProfile() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.profile);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };


    final client = CustomHttpClient(http.Client());

    try {
      final response = await client.get(
        url,
        headers: headers,
      );

      print('POST URL: $url');
      print('Request Headers: $headers');
      print('Response Code: ${response.statusCode}');
      print("-------------------------------------FULL RESPONSE-------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");
      final model = GetProfileResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          email = model.data!.user!.email.toString();
          name = model.data!.user!.name.toString();
          date_of_birth = model.data!.user!.dateOfBirth.toString();
          address = model.data!.user!.address.toString();
          phone = model.data!.user!.phoneNo.toString();

          nameController.text = model.data!.user!.name.toString();
          addressController.text = model.data!.user!.address.toString();
          phoneController.text = model.data!.user!.phoneNo.toString();


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


  Future<void> updateProfile(
      String name,
       String phone_no,
      String address,
       String date_of_birth,
      ) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.update_profile);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };
    final requestBody = {
      "name": name,
      "phone_no": phone_no,
      "date_of_birth": date_of_birth,
      "address": address,
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
            "Profile",
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