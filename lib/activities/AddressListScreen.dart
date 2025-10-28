import 'dart:convert';

import 'package:drapyy/activities/AddAddressScreen.dart';
import 'package:drapyy/helper/colors.dart';
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
import 'UpdateAddressScreen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final List<Addressesee> addresses_list = [];

  bool isLoading = false;



  @override
  void initState() {
    super.initState();
    getAddresses();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        title: const Text(
          "ADDRESSES",
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
        child: isLoading
            ? const Center( // 👈 circular loader centered
          child: CircularProgressIndicator(
            color: Colors.black, // optional color
          ),
        )
            : Column(
          children: [
            // Add icon at top right
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.black,size: 30,),
                onPressed: () async {
                  // Add new address
                  var result = await Get.to(() => AddAddressScreen());
                   if (result != null) {
                    print("Received from B: $result");
                    setState(() {
                      //myData = result;
                      getAddresses();
                    });
                  }



                },
              ),
            ),
        //Get.back(result: "Reload Address");

            // ListView below
            addresses_list.length != 0 ?
            Expanded(
              child: ListView.separated(
                itemCount: addresses_list.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.grey.shade400),
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      // ✅ Handle item click here
                      print('Clicked item: ${addresses_list[index].name}');
                      Get.back(result: {
                      'id': addresses_list[index].id.toString(),
                      'address_name': addresses_list[index].name.toString(),
                      'shipping_address': addresses_list[index].address.toString(),
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  addresses_list[index].name.toString(),
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
                                      Get.to(UpdateAddressScreen());
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
                                        deleteAddress(addresses_list[index].id.toString());
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
                          Text(
                            addresses_list[index].address.toString(),
                            style: const TextStyle(
                              fontFamily: FontConstants.gothamPro,
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
            ):
            Center(
              child: Text(
                "No Address Added",
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: carttextcolor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




  Future<void> deleteAddress(
      String id,
      ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.deleteAddress);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "address_id": id.toString(),
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
          "Address",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getAddresses();
      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
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
          "Unexpected response from server.",
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
          addresses_list.clear();
          addresses_list.addAll(model.data!.addresses as Iterable<Addressesee>);
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
