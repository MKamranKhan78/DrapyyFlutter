import 'dart:convert';

import 'package:drapyy/activities/ProductListingActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../activities/AllProductsScreen.dart';
import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';



class MenuFragment extends StatefulWidget {
  const MenuFragment({super.key});

  @override
  State<MenuFragment> createState() => _MenuFragmentState();
}

class _MenuFragmentState extends State<MenuFragment> {
  // Static list of strings
  /*final List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9",
    "Item 10",
  ];*/
  List<Categoryymeny> category_list = [];
  List<Categoryymeny> product_name_list = [];
  int selectedIndex = 0; // 👈 Default first item selected

  bool isLoading = false;

  /*final List<String> items2 = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9",
    "Item 10",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9",
    "Item 10",
  ];*/



  @override
  void initState() {
     super.initState();
    getMenuFirst("1");
  }
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 50),

          Center(
            child: Text(
              "MENU", // 👈 your text here
              style: const TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Horizontal List
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: category_list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    getMenu("2", category_list[index].id.toString());
                  },
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    alignment: Alignment.center,
                    child: Text(
                      category_list[index].name.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: FontConstants.gothamPro,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Vertical List
          Expanded( // 👈 important
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              itemCount: product_name_list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => const ProductListingActivity());

                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product_name_list[index].name.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: FontConstants.gothamPro,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// --- Main UI ---
          Column(
            children: [
              const SizedBox(height: 50),

              Center(
                child: Text(
                  "MENU",
                  style: const TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// --- Horizontal List ---
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: category_list.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedIndex;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        getMenu("2", category_list[index].id.toString());
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        alignment: Alignment.center,
                        decoration: isSelected
                            ? const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black, // underline color
                              width: 2.0,
                            ),
                          ),
                        )
                            : null,
                        child: Text(
                          category_list[index].name.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'GothamPro',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// --- Vertical List ---
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding:
                  const EdgeInsets.only(left: 10, right: 10,bottom: 10),
                  itemCount: product_name_list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => AllProductsScreen(categoryId: product_name_list[index].id.toString(),));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product_name_list[index].name.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: FontConstants.gothamPro,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          /// --- Loader Overlay ---
          if (isLoading)
            Center(
              child: CircularProgressIndicator(), // ✅ Centered progress bar
            )
        ],
      ),
    );
  }





  Future<void> getMenuFirst(
      String level,
       ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.getMenu);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "level": level.toString(),
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
      CategoryResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          category_list.clear();
          category_list.addAll(model.data!.category as Iterable<Categoryymeny>);
        });
        getMenu("2", model.data!.category![0].id.toString());
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



  Future<void> getMenu(
      String level,String category_id
       ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.getMenu);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "level": level.toString(),
      "category_id": category_id.toString(),
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
      CategoryResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          product_name_list.clear();
          product_name_list.addAll(model.data!.category as Iterable<Categoryymeny>);
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





}
