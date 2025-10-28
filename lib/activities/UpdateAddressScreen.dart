import 'dart:convert';

import 'package:drapyy/helper/SizeConstants.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/drawables.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';



class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({super.key});

  @override
  State<UpdateAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<UpdateAddressScreen> {
  bool isLoading = false;
  String? selectedValueCity_id;

  List<Cities> city_List = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bilingAddressController = TextEditingController();


  @override
  void initState() {
    super.initState();
    getCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "UPDATE ADDRESS",
                    style: TextStyle(
                      fontFamily: "Gotham Pro",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  /// Username field
                  TextField(
                    controller: nameController,
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.text, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "ENTER NAME",
                      labelStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),
                  TextField(
                    controller: mobileController,
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.phone, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "MOBILE NUMBER",
                      labelStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),
                  TextField(
                    controller: addressController,
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.text, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "ADDRESS",
                      labelStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),
                  TextField(
                    controller: bilingAddressController,
                    style: const TextStyle(fontFamily: FontConstants.gothamPro),
                    keyboardType: TextInputType.text, // ✅ email input
                    decoration: const InputDecoration(
                      labelText: "BILLING ADDRESS",
                      labelStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),



                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: DropdownSearch<String>(
                      selectedItem: city_List
                          .firstWhere(
                            (city) => city.id.toString() == selectedValueCity_id,
                        orElse: () => Cities(id: null, name: "Select City"),
                      )
                          .name,
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Search city...",
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            item,
                            style: const TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      items: city_List.map((Cities city) => city.name ?? '').toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                          hintText: "Select City",
                          hintStyle: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          final selectedCity = city_List.firstWhere(
                                (city) => city.name == newValue,
                            orElse: () => Cities(id: null, name: ''),
                          );
                          selectedValueCity_id = selectedCity.id?.toString();
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 50),



                  /// SIGNUP Button (Rectangular, no rounded corners)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {

                        if (nameController.text.trim().isEmpty) {
                          Get.snackbar(
                            "Address",
                            "Enter your name",
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(10),
                            duration: const Duration(seconds: 2),
                          );
                        } else if (mobileController.text.trim().isEmpty) {
                          Get.snackbar(
                            "Address",
                            "Enter your mobile no",
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(10),
                            duration: const Duration(seconds: 2),
                          );
                        } else if (addressController.text.trim().isEmpty) {
                          Get.snackbar(
                            "Address",
                            "Enter your address",
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(10),
                            duration: const Duration(seconds: 2),
                          );
                        } else if (bilingAddressController.text.trim().isEmpty) {
                          Get.snackbar(
                            "Address",
                            "Enter your billing address",
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(10),
                            duration: const Duration(seconds: 2),
                          );
                        }else if (selectedValueCity_id == null || selectedValueCity_id == "null") {
                          Get.snackbar(
                            "Address",
                            "Please select your city",
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(10),
                            duration: const Duration(seconds: 2),
                          );
                        }else{
                          updateAddress(
                              nameController.text.toString(),
                              mobileController.text.toString(),
                              addressController.text.toString(),
                              bilingAddressController.text.toString(),
                              selectedValueCity_id.toString(),
                              "1"
                          );
                        }

                        print("selectedValueCity add------------>"+selectedValueCity_id.toString());

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        "Update ADDRESS",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          /// Loading Overlay
          if (isLoading)
            Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
        ],
      ),
    );
  }





  Future<void> updateAddress(
      String name,
      String phone_no,
      String address,
      String billing_address,
      String city,
      String is_default,
      ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.addressUpdate);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "name": name.toString(),
      "phone_no": phone_no.toString(),
      "address": address.toString(),
      "billing_address": billing_address.toString(),
      "city": city.toString(),
      "is_default": is_default.toString(),
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
        Get.back();
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
          city_List.clear();
          city_List.addAll(model.data!.cities as Iterable<Cities>);


          if(model.data!.address != null){
            if(model.data!.address!.id != null){
              selectedValueCity_id = model.data!.address!.id.toString();
            }
            if(model.data!.address!.name != null){
              nameController.text = model.data!.address!.name.toString();
            }
            if(model.data!.address!.phoneNo != null){
              mobileController.text = model.data!.address!.phoneNo.toString();
            }
            if(model.data!.address!.address != null){
              addressController.text = model.data!.address!.address.toString();
            }
            if(model.data!.address!.billingAddress != null){
              bilingAddressController.text = model.data!.address!.billingAddress.toString();
            }

          }
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Address",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Address",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Address",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Address",
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






























