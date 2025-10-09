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

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final List<String> addresses = [
    "9-E-2 BLOCK E 2 GULBERG III, LAHORE, PUNJAB",
    "9-E-2 BLOCK E 2 GULBERG III, LAHORE, PUNJAB",
    "9-E-2 BLOCK E 2 GULBERG III, LAHORE, PUNJAB",
    "9-E-2 BLOCK E 2 GULBERG III, LAHORE, PUNJAB",
    "9-E-2 BLOCK E 2 GULBERG III, LAHORE, PUNJAB",
    "9-E-2 BLOCK E 2 GULBERG III, LAHORE, PUNJAB",
    "9-E-2 BLOCK E 2 GULBERG III, LAHORE, PUNJAB",
    "9-E-2 BLOCK E 2 GULBERG III, LAHORE, PUNJAB",
  ];

  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // 👈 keeps content below status bar
        child: Column(
          children: [
            // Back arrow with left padding
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 8.0), // 👈 space from start & top
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.black),
                ),
              ),
            ),

            // Add icon at top right
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.black,size: 30,),
                onPressed: () {
                  // Add new address

                  Get.to(() => const AddAddressScreen());
                },
              ),
            ),

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
                            Row(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () {
                                    // Edit address
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.edit,
                                        size: 18, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () {
                                    setState(() {
                                      addresses.removeAt(index);
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.delete,
                                        size: 18, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Text(
                          "dhfj djfh jhd fjkhdjkfh hdf h dhfjdhf hd fh dfdgd fgdf gfdfgvvgdfgvdfvg gdfg df ",
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


  Future<void> getAddresses() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.address);
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
      final model = GetAddressesResponse.fromJson(json.decode(response.body));
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
