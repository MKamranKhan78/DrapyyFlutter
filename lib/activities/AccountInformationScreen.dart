
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';
import 'ChangePasswordScreen.dart';
import 'UpdateProfileScreen.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {



  bool isLoading = false;

  String name = "";
  String email = "";
  String date_of_birth = "";
  String address = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    getProfile();
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(), // ✅ Centered loader
        )
            : SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.back(result: "Reload Address");



          return true; // ✅ must return a bool
    },
    child: Scaffold(
    body: SafeArea(
    child: isLoading
    ? const Center(
    child: CircularProgressIndicator(), // ✅ Centered loader
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
                   Get.back(result: "Reload Address");
                },
              ),

              const SizedBox(height: 40),

              // Title
              Text(
                "ACCOUNT INFORMATION",
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              // Email
              _infoRow("EMAIL:", email.toString()),
              const Divider(thickness: 1, color: Colors.black),

              // Name
              _infoRow("NAME:", name.toString()),
              const Divider(thickness: 1, color: Colors.black),

              // DOB
              _infoRow("DATE OF BIRTHDAY:", date_of_birth.toString()),
              const Divider(thickness: 1, color: Colors.black),

              // Address
              _infoRow("ADDRESS:", address.toString()),
              const Divider(thickness: 1, color: Colors.black),

              // Phone
              _infoRow("PHONE:", phone.toString()),

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
                  onPressed: () async {
                    //Get.to(UpdateProfileScreen());

                    var result = await Get.to(() => UpdateProfileScreen());
                    if (result != null) {
                      print("Received from B: $result");
                      setState(() {
                        getProfile();
                      });
                    }

                  },
                  child: Text(
                    "EDIT",
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
                  onPressed: () async {
                    //Get.to(ChangePasswordScreen());
                    var result = await Get.to(() => ChangePasswordScreen());
                    if (result != null) {
                      print("Received from B: $result");
                      setState(() {
                        getProfile();
                      });
                    }
                  },
                  child: Text(
                    "CHANGE PASSWORD",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    ),);
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
         });
      } else if (model.status == 0) {
        Get.snackbar(
          "Profile",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Profile",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Profile",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Profile",
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

  // Widget for each row
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: FontConstants.gothamPro,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // ✅ enable horizontal scrolling
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}