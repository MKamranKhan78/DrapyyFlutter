
// Current Orders Fragment
import 'dart:convert';

import 'package:drapyy/helper/colors.dart';
import 'package:drapyy/helper/drawables.dart';
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




class CurrentOrdersFragment extends StatefulWidget {
  const CurrentOrdersFragment({super.key});

  @override
  State<CurrentOrdersFragment> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<CurrentOrdersFragment> {

  bool isLoading = false;
  List<Orderss> order_list = [];

  @override
  void initState() {
     super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            const Text(
              "MY ORDERS",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30, width: 30),
          ],
        ),

      ),

      // ✅ Body content
      body: Container(
        color: Colors.white,
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(color: Colors.black),
        )
            : order_list.isEmpty
            ? const Center(
          child: Text(
            'No order found',
            style: TextStyle(
              fontFamily: FontConstants.gothamPro,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        )
            : ListView.builder(
          itemCount: order_list.length,
          itemBuilder: (context, index) {
            String orderId = 'ORDER ID# ${order_list[index].id}';
            String trackingNumber =
            order_list[index].invoiceNo.toString();
            String productName = order_list[index]
                .orderItemsStack![0]
                .productName
                .toString();
            String quantity =
                'Qty ${order_list[index].orderItemsStack![0].quantity}';
            String status =
            order_list[index].orderStatus.toString();

            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order ID + Tracking Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orderId,
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        trackingNumber,
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Product Details Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Product Image from server
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          order_list[index]
                              .orderItemsStack![0]
                              .productImage ??
                              '',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                                'assets/images/placeholder.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Product Info (Name, Qty, Status)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  quantity,
                                  style: TextStyle(
                                    fontFamily:
                                    FontConstants.gothamPro,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    status,
                                    style: const TextStyle(
                                      fontFamily:
                                      FontConstants.gothamPro,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Container(height: 1, color: black_color),
                ],
              ),
            );
          },
        ),
      ),
    );
  }



  Future<void> getOrders() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.orders);
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
      final model = GetOrderResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          order_list.clear();
          order_list.addAll(model.data!.orders as Iterable<Orderss>);
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Orders",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Orders",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Orders",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Orders",
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