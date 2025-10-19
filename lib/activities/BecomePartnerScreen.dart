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
  List<Cities> cities_list = [];

  String? selectedValueStoreType;
  List<StoreType> storeList = [];

  String? selectedCatalog;
  List<String> list_catalog = [];

  String? selectedHasWeb;
  List<String> list_has_web = [];

  String? selectedSupplyChainn;
  List<String> listSupplyChainn = [];

  String? selectedProduceInventoryy;
  List<String> listInventoryy = [];

  bool isLoading = false;


  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController socialController = TextEditingController();




  @override
  void initState() {
    super.initState();
    getCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                  controller: brandNameController,
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
                  controller: nameController,
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
                  controller: emailController,
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.emailAddress, // ✅ email input
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
                  controller: mobileController,
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.phone, // ✅ email input
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
                    "SELECT CITY",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: cities_list.map((Cities value) {
                    return DropdownMenuItem<String>(
                      value: value.name.toString(),
                      child: Text(
                        value.name.toString(),
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
                  value: selectedCatalog,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "SELECT CATALOG",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: list_catalog.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value.toString(),
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
                      selectedCatalog = newValue;
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
                    "SELECT STORE TYPE",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: storeList.map((StoreType value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(
                        value.name.toString(),
                        style: TextStyle(
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
                  value: selectedHasWeb,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "SELECT OPTION FOR WEBSITE",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: list_has_web.map((String value) {
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
                      selectedHasWeb = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedSupplyChainn,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "SELECT SUPPLY CHAIN",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listSupplyChainn.map((String value) {
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
                      selectedSupplyChainn = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedProduceInventoryy,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "SELECT PRODUCE INVENTORY",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listInventoryy.map((String value) {
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
                      selectedProduceInventoryy = newValue;
                    });
                  },
                ),
              ),



              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: websiteController,
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.webSearch, // ✅ email input
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
                  controller: socialController,
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.webSearch, // ✅ email input
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

                          if(selectedValueCity == null || selectedValueCity == "null"){
                            Get.snackbar(
                              "Validation",
                              "Please select city",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 2),
                            );
                          }else if(selectedValueStoreType == null || selectedValueStoreType == "null"){
                            Get.snackbar(
                              "Validation",
                              "Please Store Type",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 2),
                            );
                          }else if(selectedCatalog == null || selectedCatalog == "null"){
                            Get.snackbar(
                              "Validation",
                              "Please Select Catalog",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 2),
                            );
                          }else if(selectedHasWeb == null || selectedHasWeb == "null"){
                            Get.snackbar(
                              "Validation",
                              "Please Select Website",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 2),
                            );
                          }else if(selectedSupplyChainn == null || selectedSupplyChainn == "null"){
                            Get.snackbar(
                              "Validation",
                              "Please Select Supply Chain",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 2),
                            );
                          }else if(selectedProduceInventoryy == null || selectedProduceInventoryy == "null"){
                            Get.snackbar(
                              "Validation",
                              "Please Select Inventory",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 2),
                            );
                          }else {

                            print("selectedValueCity------>"+selectedValueCity.toString());
                            print("selectedValueStoreType------>"+selectedValueStoreType.toString());
                            print("selectedCatalog------>"+selectedCatalog.toString());
                            print("selectedHasWeb------>"+selectedHasWeb.toString());
                            print("selectedSupplyChainn------>"+selectedSupplyChainn.toString());
                            print("selectedProduceInventoryy------>"+selectedProduceInventoryy.toString());

                            if (_validateInputs()) {
                              becomeSeller(
                                  brandNameController.text.trim().toString(),
                                  nameController.text.trim().toString(),
                                  emailController.text.trim(),
                                  mobileController.text.trim(),
                                  selectedHasWeb.toString(),
                                  selectedValueCity.toString(),
                                  websiteController.text.trim().isEmpty ? "" : websiteController.text.trim(),
                                  socialController.text.trim().toString(),
                                  selectedProduceInventoryy.toString(),
                                  selectedSupplyChainn.toString(),
                                  selectedCatalog.toString(),
                                  selectedValueStoreType.toString()
                              );
                            }


                          }
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

  bool _validateInputs() {
    if (brandNameController.text.trim().isEmpty) {
      _showError("Please enter brand name");
      return false;
    } else if (nameController.text.trim().isEmpty) {
      _showError("Please enter your name");
      return false;
    } else if (emailController.text.trim().isEmpty ||
        !RegExp(
          r"^[\w\.-]+@[\w\.-]+\.\w+$",
        ).hasMatch(emailController.text.trim())) {
      _showError("Please enter a valid email address");
      return false;
    } else if (mobileController.text.trim().isEmpty) {
      _showError("Please enter your mobile number");
      return false;
    }else if (socialController.text.trim().isEmpty) {
      _showError("Please enter social url");
      return false;
    }
    return true;
  }


  void _showError(String message) {
    Get.snackbar(
      "Validation Error",
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
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
        print("CITY_ID---------->"+model.data!.address!.city.toString());
        setState(() {
          cities_list.clear();
          cities_list.addAll(model.data!.cities as Iterable<Cities>);
          becomeSellerData();
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

          if(model.data!.store_type!.length > 0){
            storeList.clear();
            storeList.addAll(model.data!.store_type as Iterable<StoreType>);
          }

          if(model.data!.catalogue_size!.length > 0){
            list_catalog.clear();
            list_catalog.addAll(model.data!.catalogue_size as Iterable<String>);
          }

          if(model.data!.has_website!.length > 0){
            list_has_web.clear();
            list_has_web.addAll(model.data!.has_website as Iterable<String>);
          }

          if(model.data!.supply_chain!.length > 0){
            listSupplyChainn.clear();
            listSupplyChainn.addAll(model.data!.supply_chain as Iterable<String>);
          }

          if(model.data!.production_inventory!.length > 0){
            listInventoryy.clear();
            listInventoryy.addAll(model.data!.production_inventory as Iterable<String>);
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

/*

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
      GeneralModel.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          isLoading = false;
          Get.snackbar(
            "Status ${model.status}",
            model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2),
          );
          Get.back();
        });

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

*/


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
    if (!mounted) return;
    setState(() => isLoading = true);

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.becomeSeller);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {
      "brand_name": brand_name,
      "name": name,
      "email": email,
      "phone_no": phone_no,
      "has_website": has_website,
      "city": city,
      "website_url": website_url,
      "social_url": social_url,
      "production_inventory": production_inventory,
      "supply_chain": supply_chain,
      "catalogue_size": catalogue_size,
      "business_operation": business_operation,
    };

    final client = CustomHttpClient(http.Client());

    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      // Debug logs — inspect these in console
      print('POST URL: $url');
      print('Request Headers: $headers');
      print('Request Body: ${jsonEncode(requestBody)}');
      print('Response Code: ${response.statusCode}');
      Toastutils.printFullText(response.body.toString());
      print('RAW RESPONSE: ${response.body}');

      // Parse response (ensure your model maps status/message fields)
      final model = GeneralModel.fromJson(json.decode(response.body));
      print('PARSED STATUS: ${model.status}, MESSAGE: ${model.message}');

      // Stop loading first
      if (mounted) setState(() => isLoading = false);

      if (model.status == 1) {
        // Show snack AFTER the current frame so overlays can attach cleanly
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Try Get.snackbar first
          try {
            Get.snackbar(
              "Success",
              model.message ?? "Successfully Registered",
              backgroundColor: Colors.black,
              colorText: Colors.white,
              margin: const EdgeInsets.all(10),
              duration: const Duration(seconds: 2),
            );
          } catch (e) {
            // Fallback to ScaffoldMessenger if Get fails (e.g. not using GetMaterialApp)
            final messenger = ScaffoldMessenger.maybeOf(context);
            if (messenger != null) {
              messenger.showSnackBar(SnackBar(
                content: Text(model.message ?? "Successfully Registered"),
                duration: const Duration(seconds: 2),
              ));
            } else {
              print('Could not show snackbar: $e');
            }
          }

          // Give the snackbar a short time to appear, then pop
          Future.delayed(const Duration(milliseconds: 800), () {
            // Prefer Get.back if Get is available, otherwise use Navigator
            try {
              if (Get.isOverlaysOpen != null) {
                Get.back(); // safe if using GetMaterialApp
              } else {
                Navigator.of(context).maybePop();
              }
            } catch (e) {
              // Final fallback
              Navigator.of(context).maybePop();
            }
          });
        });
      } else {
        // Non-success responses: show message immediately
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            Get.snackbar(
              "Status ${model.status}",
              model.message ?? "Something went wrong",
              backgroundColor: Colors.black,
              colorText: Colors.white,
              margin: const EdgeInsets.all(10),
              duration: const Duration(seconds: 2),
            );
          } catch (e) {
            final messenger = ScaffoldMessenger.maybeOf(context);
            messenger?.showSnackBar(SnackBar(
              content: Text(model.message ?? "Something went wrong"),
              duration: const Duration(seconds: 2),
            ));
          }
        });
      }
    } catch (e) {
      if (mounted) setState(() => isLoading = false);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          Get.snackbar(
            "Error",
            e.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2),
          );
        } catch (_) {
          final messenger = ScaffoldMessenger.maybeOf(context);
          messenger?.showSnackBar(SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 2),
          ));
        }
      });
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }




}