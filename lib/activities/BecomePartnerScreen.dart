import 'dart:convert';

import 'package:drapyy/helper/colors.dart';
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

class BecomePartnerScreen extends StatefulWidget {
  const BecomePartnerScreen({super.key});

  @override
  State<BecomePartnerScreen> createState() => _BecomePartnerScreenState();
}

class _BecomePartnerScreenState extends State<BecomePartnerScreen> {

  String? selectedValueCity;

  final List<String> cityList = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];
  String? selectedValueOption;

  final List<String> listOption = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  String? selectedValueOption1;

  final List<String> listOption1 = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  String? selectedSupplyChain;

  final List<String> listSupplyChain = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  String? selectedProduceInventory;

  final List<String> listInventory = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  String? selectedValueStoreType;

  final List<String> storeList = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    becomeSellerData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // 👈 scrollable if content grows
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        // Back arrow
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),

                        // Title centered
                        Expanded(
                          child: Center(
                            child: Text(
                              'BECOME SELLER',
                              style: const TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        // Spacer to balance
                        const SizedBox(width: 48),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "ENTER YOUR BRAND NAME",
                    labelStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                      color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "ENTER YOUR NAME",
                    labelStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                      color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "ENTER YOUR EAMIL",
                    labelStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                      color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "ENTER YOUR PHONE",
                    labelStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                      color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),


              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedValueOption,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select option",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listOption.map((String value) {
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
                      selectedValueOption = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedValueStoreType,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select Store Type",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: storeList.map((String value) {
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
                      selectedValueStoreType = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedValueOption1,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select Option",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listOption1.map((String value) {
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
                      selectedValueOption1 = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedSupplyChain,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select Supply Chain",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listSupplyChain.map((String value) {
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
                      selectedSupplyChain = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedProduceInventory,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select PRODUCE INVENTORY",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listInventory.map((String value) {
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
                      selectedProduceInventory = newValue;
                    });
                  },
                ),
              ),



              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "WEBSITE LINK",
                    labelStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                        color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "SOCIAL LINK",
                    labelStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                        color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),




              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {

                         },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 15,
                          ),
                          child: Center(
                            child: Text(
                              'SUBMIT REQUEST',
                              style: TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 12, // Slightly smaller for grid layout
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
             ],
          ),
        ),
      ),
    );
  }



  Future<void> becomeSellerData() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.become_seller_data);
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
      final model = GetBecomeSellerResponse.fromJson(json.decode(response.body));
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


  Future<void> becomeSeller(
      String brand_name,
      String name,
      String email,
      String phone_no,
      String has_website,
      String city,
      String website_url,
      String social_url,
      String production_inventory,
      String supply_chain,
      String catalogue_size,
      String business_operation,
      ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.becomeSeller);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "brand_name": brand_name.toString(),
      "name": name.toString(),
      "email": email.toString(),
      "phone_no": phone_no.toString(),
      "has_website": has_website.toString(),
      "city": city.toString(),
      "website_url": website_url.toString(),
      "social_url": social_url.toString(),
      "production_inventory": production_inventory.toString(),
      "supply_chain": supply_chain.toString(),
      "catalogue_size": catalogue_size.toString(),
      "business_operation": business_operation.toString(),
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
      AddWishlistModell.fromJson(json.decode(response.body));

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