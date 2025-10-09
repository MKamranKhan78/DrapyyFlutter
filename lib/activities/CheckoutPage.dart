
import 'dart:convert';

import 'package:drapyy/activities/SuccessScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';


class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<CheckoutPage> {
  String? selectedShipping;
  String? selectedPayment;
  bool isLoading = false;

  final List<String> shippingMethods = [
    "Standard Delivery",
    "Express Delivery",
    "Pickup"
  ];
  final List<String> paymentMethods = [
    "Credit Card",
    "Cash on Delivery",
    "Bank Transfer"
  ];

  @override
  void initState() {
     super.initState();
    getCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        title: const Text(
          "MY ORDER",
          style: TextStyle(
            fontFamily: "Gotham Pro",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            children: [
              // Main scrollable content
              Expanded(
                child: ListView(
                  children: [
                    // SHIPPING ADDRESS
                    const Text(
                      "SHIPPING ADDRESS",
                      style: TextStyle(
                        fontFamily: "Gotham Pro",
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      title: const Text(
                        "dummy text",
                        style: TextStyle(fontFamily: "Gotham Pro"),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.black),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: const Text(
                        "dummy text",
                        style: TextStyle(fontFamily: "Gotham Pro"),
                      ),
                      trailing:
                      const Icon(Icons.add, size: 20, color: Colors.black),
                      subtitle: const Text(
                        "ADD SHIPPING ADDRESS",
                        style: TextStyle(
                          fontFamily: "Gotham Pro",
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const Divider(),

                    // SHIPPING METHOD DROPDOWN
                    const Text(
                      "SHIPPING METHOD",
                      style: TextStyle(
                        fontFamily: "Gotham Pro",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedShipping,
                        hint: const Text(
                          "SELECT SHIPPING METHOD",
                          style: TextStyle(fontFamily: "Gotham Pro"),
                        ),
                        isExpanded: true,
                        items: shippingMethods
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(
                                fontFamily: "Gotham Pro"),
                          ),
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedShipping = val;
                          });
                        },
                      ),
                    ),
                    const Divider(),

                    // PAYMENT METHOD DROPDOWN
                    const Text(
                      "PAYMENT METHOD",
                      style: TextStyle(
                        fontFamily: "Gotham Pro",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedPayment,
                        hint: const Text(
                          "SELECT PAYMENT METHOD",
                          style: TextStyle(fontFamily: "Gotham Pro"),
                        ),
                        isExpanded: true,
                        items: paymentMethods
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(
                                fontFamily: "Gotham Pro"),
                          ),
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedPayment = val;
                          });
                        },
                      ),
                    ),
                    const Divider(),

                    // VOUCHER SECTION
                    const Text(
                      "VOUCHER",
                      style: TextStyle(
                        fontFamily: "Gotham Pro",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Select voucher",
                        style: TextStyle(
                          fontFamily: "Gotham Pro",
                          color: Colors.grey,
                        ),
                      ),
                      trailing:
                      const Icon(Icons.add, size: 20, color: Colors.black),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const Divider(),

                  ],
                ),
              ),

              // TOTAL + PLACE ORDER
              SafeArea(
                minimum: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "TOTAL",
                          style: TextStyle(
                            fontFamily: "Gotham Pro",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "2999",
                          style: TextStyle(
                            fontFamily: "Gotham Pro",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Discount",
                      style: TextStyle(
                        fontFamily: "Gotham Pro",
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(),
                        ),
                        onPressed: () {
                          Get.to(() => SuccessScreen());

                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PLACEORDER",
                              style: TextStyle(
                                fontFamily: "Gotham Pro",
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "2999",
                              style: TextStyle(
                                fontFamily: "Gotham Pro",
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getCheckout() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.checkout);
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
      final model = GetCheckoutResponse.fromJson(json.decode(response.body));
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
