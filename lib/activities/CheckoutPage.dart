
import 'dart:convert';

import 'package:drapyy/activities/MyVoucherListingScreen.dart';
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
import 'AddressListScreen.dart';


class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<CheckoutPage> {
  ShippingMethod? selectedShipping;
  String? shipping_id;
  String? selectedPayment;
  String? address_id;
  String voucher = "";
  String is_voucher = "0";
  bool isLoading = false;
  String address_name = "";
  String shipping_add = "";
  String total = "";
  String discount = "";
  final List<ShippingMethod> shippingMethods_list = [];
  List<String> paymentMethods_list = [];

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
          "CHECKOUT",
          style: TextStyle(
            fontFamily: "Gotham Pro",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            children: [
              // Main scrollable content
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "SHIPPING ADDRESS",
                      style: TextStyle(
                        fontFamily: "Gotham Pro",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                   /* InkWell(
                      onTap: () async {
                        var result = await Get.to(() => AddressListScreen());
                        if (result != null) {
                          print("Returned data: $result"); // prints: {id: 123, name: Kamran}
                           setState(() {
                             address_id = result['id']; // 👈 extract specific field
                             address_name = result['address_name']; // 👈 extract specific field
                             shipping_add = result['shipping_address']; // 👈 extract specific field
                           });
                        }
                      },
                      child: ListTile(
                        title: Text(
                          address_name.isEmpty ? "ADD ADDRESS" : address_name.toString(),
                          style: TextStyle(fontFamily: "Gotham Pro"),
                        ),
                        trailing:
                        Icon(Icons.add, size: 20, color: Colors.black),
                        subtitle: Text(
                          shipping_add.isEmpty ? "ADD SHIPPING ADDRESS" : shipping_add.toString(),
                          style: TextStyle(
                            fontFamily: "Gotham Pro",
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const Divider(),*/

                    InkWell(
                      onTap: () async {
                        var result = await Get.to(() => AddressListScreen());
                        if (result != null) {
                          print("Returned data: $result"); // prints: {id: 123, name: Kamran}
                          setState(() {
                            address_id = result['id'];
                            address_name = result['address_name'];
                            shipping_add = result['shipping_address'];
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6), // 👈 reduced space
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address_name.isEmpty ? "ADD ADDRESS" : address_name.toString(),
                                    style: const TextStyle(
                                      fontFamily: "Gotham Pro",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 2), // 👈 minimal gap between title & subtitle
                                  Text(
                                    shipping_add.isEmpty
                                        ? "ADD SHIPPING ADDRESS"
                                        : shipping_add.toString(),
                                    style: const TextStyle(
                                      fontFamily: "Gotham Pro",
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.add, size: 20, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1),


                    Container(height: 20,),
                    // SHIPPING METHOD DROPDOWN
                    Text(
                      "SHIPPING METHOD",
                      style: TextStyle(
                        fontFamily: "Gotham Pro",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<ShippingMethod>(
                        value: selectedShipping,
                        hint: const Text(
                          "SELECT SHIPPING METHOD",
                          style: TextStyle(fontFamily: "Gotham Pro"),
                        ),
                        isExpanded: true,
                        items: shippingMethods_list
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name.toString(),
                            style: const TextStyle(
                                fontFamily: "Gotham Pro"),
                          ),
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedShipping = val;
                            shipping_id = val!.id.toString();
                          });
                        },
                      ),
                    ),
                    Divider(),

                    // PAYMENT METHOD DROPDOWN
                    Text(
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
                        items: paymentMethods_list
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
                    InkWell(
                      onTap: () async {
                        var result = await Get.to(() => MyVoucherListingScreen());
                        if (result != null) {
                          print("Returned data: $result"); // prints: {id: 123, name: Kamran}
                          setState(() {
                            voucher = result['v_code'];
                            applyCouponCode(voucher);
                            });
                        }
                      },
                      child: ListTile(
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
                      children: [
                        Text(
                          "TOTAL",
                          style: TextStyle(
                            fontFamily: "Gotham Pro",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "PKR "+total.toString(),
                          style: TextStyle(
                            fontFamily: "Gotham Pro",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(
                            fontFamily: "Gotham Pro",
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          discount.toString().isEmpty ? "No Discount Applied" : discount.toString(),
                          style: TextStyle(
                            fontFamily: "Gotham Pro",
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
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

                          if(selectedPayment == null){
                            Get.snackbar(
                              "Checkout",
                              "Please select payment method.",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 2),
                            );
                          } else if(shipping_id == null){
                            Get.snackbar(
                              "Checkout",
                              "Please select shipping method.",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 2),
                            );
                          } else if(address_id == null || address_id == "null" || address_id.toString().isEmpty){
                            Get.snackbar(
                              "Checkout",
                              "Please select shipping address.",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 2),
                            );
                          }else{

                            print("ADDRESS_ID"+address_id.toString());
                            placeOrder(shipping_id!, selectedPayment!, voucher, is_voucher, address_id!);

                          }
                        },
                        child: Row(
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
                              "PKR "+total.toString(),
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
        print("MESSAGE---------->"+model.message.toString());
        setState(() {


          if (model.data?.paymentMethods != null && model.data!.paymentMethods!.isNotEmpty) {
            paymentMethods_list
              ..clear()
              ..addAll(model.data!.paymentMethods!);
          }

          if (model.data?.shippingMethod != null && model.data!.shippingMethod!.isNotEmpty) {
            shippingMethods_list
              ..clear()
              ..addAll(model.data!.shippingMethod!);
          }

          if (model.data?.address?.id != null) {
            address_id = model.data!.address!.id.toString();
            address_name = model.data!.address!.name.toString();
            shipping_add = model.data!.address!.address.toString();
          }

          if (model.data?.total != null) {
            total = model.data!.total.toString();
          }



        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Checkout",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Checkout",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Checkout",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Checkout",
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

  Future<void> placeOrder(
      String shipping_method,
      String payment_method,
      String voucher,
      String is_voucher,
      String address_id,
      ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.placeOrder);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "shipping_method": shipping_method.toString(),
      "payment_method": payment_method.toString(),
      "voucher": voucher.toString(),
      "is_voucher": is_voucher.toString(),
      "address": address_id.toString()
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
          "Orders",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        Get.to(() => SuccessScreen());
      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
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
          "Unexpected response from server.",
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


  Future<void> applyCouponCode(
      String voucher,
      ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.applyCoupon);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "voucher": voucher.toString(),
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
      print("-------------------------------------------------------------------------------------");

      final model =
      VoucherResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          is_voucher = "1";

          if (model.data?.total != null) {
            total = model.data!.total.toString();
            discount = model.data!.discountAmount.toString();
          }
          Get.snackbar(
            "Coupon",
            model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2),
          );
        });
      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
        Get.snackbar(
          "Coupon",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Coupon",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Coupon",
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
