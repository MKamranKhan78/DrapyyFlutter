import 'dart:convert';

import 'package:drapyy/activities/ProductListingActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

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
  List<Categoryymeny> category_list = [];
  List<Categoryymeny> product_name_list = [];
  int selectedIndex = 0;

  bool isLoading = false;
  bool isInitialLoading = true; // 👈 New flag for initial loading

  @override
  void initState() {
    super.initState();
    getMenuFirst("1");
  }

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
                child: _buildHorizontalList(),
              ),

              /// --- Vertical List ---
              Expanded(
                child: _buildVerticalList(),
              ),
            ],
          ),

          /// --- Loader Overlay ---
          if (isLoading && !isInitialLoading) // 👈 Show only for subsequent loads
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }

  Widget _buildHorizontalList() {
    if (isInitialLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: 6, // 👈 Show 6 shimmer items
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              width: 80,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          },
        ),
      );
    }

    return ListView.builder(
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
                  color: Colors.black,
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
    );
  }

  Widget _buildVerticalList() {
    if (isInitialLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          itemCount: 8, // 👈 Show 8 shimmer items
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      itemCount: product_name_list.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(() => AllProductsScreen(categoryId: product_name_list[index].id.toString()));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
    );
  }

  Future<void> getMenuFirst(String level) async {
    setState(() {
      isLoading = true;
      isInitialLoading = true; // 👈 Set initial loading to true
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.getMenu);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

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
      print("-------------------------------------FULL RESPONSE-------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");

      final model = CategoryResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          category_list.clear();
          category_list.addAll(model.data!.category as Iterable<Categoryymeny>);
        });
        getMenu("2", model.data!.category![0].id.toString());
      } else if (model.status == 0 || model.status == 401 || model.status != null) {
        Get.snackbar(
          "Menu",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Menu",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Menu",
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

  Future<void> getMenu(String level, String category_id) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.getMenu);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

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
      print("-------------------------------------FULL RESPONSE-------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");

      final model = CategoryResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          product_name_list.clear();
          product_name_list.addAll(model.data!.category as Iterable<Categoryymeny>);
          isInitialLoading = false; // 👈 Set initial loading to false after first successful data load
        });
      } else if (model.status == 0 || model.status == 401 || model.status != null) {
        Get.snackbar(
          "Menu",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Menu",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Menu",
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