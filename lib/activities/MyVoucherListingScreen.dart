import 'dart:convert';

import 'package:drapyy/activities/AddAddressScreen.dart';
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

class MyVoucherListingScreen extends StatefulWidget {
  const MyVoucherListingScreen({super.key});

  @override
  State<MyVoucherListingScreen> createState() => _MyVoucherListingScreenState();
}

class _MyVoucherListingScreenState extends State<MyVoucherListingScreen> {
  final List<String> addresses = [
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
  ];
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // 👈 keeps content below status bar
        child: Column(
          children: [
            // Back arrow with left padding
            Row(
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),

                // Expanded makes the Text take remaining space and stay centered
                Expanded(
                  child: Center(
                    child: Text(
                      "MY VOUCHERS", // 👈 your text here
                      style: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // To balance Row (so title stays centered even with only one button)
                const SizedBox(width: 48), // same width as IconButton
              ],
            ),

            Container(height: 20,),


            // ListView below
            Expanded(
              child: ListView.separated(
                itemCount: addresses.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.grey.shade400),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                addresses[index],
                                style: const TextStyle(
                                  fontFamily: FontConstants.gothamPro,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "test44553",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getVoucherList() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.voucher);
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
      final model = GetVoucherlistResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
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
