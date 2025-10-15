import 'dart:convert';

import 'package:drapyy/activities/AddAddressScreen.dart';
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

class MyVoucherListingScreen extends StatefulWidget {
  const MyVoucherListingScreen({super.key});

  @override
  State<MyVoucherListingScreen> createState() => _MyVoucherListingScreenState();
}

class _MyVoucherListingScreenState extends State<MyVoucherListingScreen> {
  final List<Voucherr> voucher_list = [];
  bool isLoading = false;


  @override
  void initState() {
     super.initState();
    getVoucherList();
  }

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
                const Expanded(
                  child: Center(
                    child: Text(
                      "MY VOUCHERS", // 👈 your text here
                      style: TextStyle(
                        fontFamily: 'GothamPro', // ✅ FontConstants.gothamPro
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // To balance Row (so title stays centered even with only one button)
                SizedBox(width: 48), // same width as IconButton
              ],
            ),

            const SizedBox(height: 20),

            // Main Content
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(), // ✅ Loading state
              )
                  : voucher_list.isEmpty
                  ? const Center(
                child: Text(
                  "No vouchers found", // ✅ Empty list state
                  style: TextStyle(
                    fontFamily: 'GothamPro',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
                  :ListView.separated(
                itemCount: voucher_list.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.grey.shade400),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // 👇 handle tap here
                      print("Tapped on voucher id: ${voucher_list[index].id}");

                      Get.back(result: {
                        'v_code': voucher_list[index].code.toString(),
                      });

                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "USE PROMOCODE ${voucher_list[index].id.toString()}",
                                  style: TextStyle(
                                    fontFamily: 'GothamPro',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                               formatDate(voucher_list[index].created_at.toString()),
                                style: TextStyle(
                                  fontFamily: 'GothamPro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),


                            ],
                          ),
                          Text(
                            voucher_list[index].title.toString(),
                            style: const TextStyle(
                              fontFamily: 'GothamPro',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
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


  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      DateTime dateTime = DateTime.parse(dateStr).toLocal();
      return DateFormat('dd MMM yyyy, h:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
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
         if(model.data!.vouchers!.length >0){
           voucher_list.clear();
           voucher_list.addAll(model.data!.vouchers as Iterable<Voucherr>);
         }
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
