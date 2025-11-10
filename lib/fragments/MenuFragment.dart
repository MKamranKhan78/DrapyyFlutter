import 'dart:convert';
import 'package:drapyy/activities/ProductListingActivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
  List<Categoryymeny> sub_category_list = [];

  int selectedIndex = 0;
  String category_id = "";
  int? expandedIndex; // ✅ which parent index is expanded

  bool isLoading = false;
  bool isInitialLoading = true;

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
              SizedBox(height: 80, child: _buildHorizontalList()),
              Expanded(child: _buildVerticalList()),
            ],
          ),

          if (isLoading && !isInitialLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  // ------------------- Horizontal List -------------------
  Widget _buildHorizontalList() {
    if (isInitialLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
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
              category_id = category_list[index].id.toString();
            });
            getMenu("2", category_id);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            alignment: Alignment.center,
            decoration: isSelected
                ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black, width: 2.0),
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

  // ------------------- Vertical List -------------------
  Widget _buildVerticalList() {
    if (isInitialLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: 8,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      itemCount: product_name_list.length,
      itemBuilder: (context, index) {
        final item = product_name_list[index];
        final isExpanded = expandedIndex == index; // ✅ fixed condition

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                getCategoryThree("3", item.id.toString(), index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  item.name.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: FontConstants.gothamPro,
                  ),
                ),
              ),
            ),

            if (isExpanded && sub_category_list.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: sub_category_list.map((sub) {
                    return InkWell(
                      onTap: () {
                      //  Fluttertoast.showToast(msg: "Clicked on ${sub.name}");
                        Get.to(() => AllProductsScreen(categoryId: sub.id.toString()));



                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "- ${sub.name}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  // ------------------- API 1: Get Top Menu -------------------
  Future<void> getMenuFirst(String level) async {
    setState(() {
      isLoading = true;
      isInitialLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.getMenu);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {"level": level};

    final client = CustomHttpClient(http.Client());

    try {
      final response =
      await client.post(url, headers: headers, body: jsonEncode(requestBody));

      print('POST URL: $url');
      print('Response: ${response.body}');

      final model = CategoryResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          category_list
            ..clear()
            ..addAll(model.data!.category ?? []);
          category_id = category_list.first.id.toString();
        });
        getMenu("2", category_id);
      } else {
        _showError(model.message ?? "Unexpected response from server.");
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  // ------------------- API 2: Get Sub Menu -------------------
  Future<void> getMenu(String level, String category_id) async {
    setState(() => isLoading = true);

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.getMenu);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {"level": level, "category_id": category_id};
    final client = CustomHttpClient(http.Client());

    try {
      final response =
      await client.post(url, headers: headers, body: jsonEncode(requestBody));

      print('POST URL: $url');
      print('Response: ${response.body}');

      final model = CategoryResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          product_name_list
            ..clear()
            ..addAll(model.data!.category ?? []);
          isInitialLoading = false;
          expandedIndex = null; // ✅ correct tracking

        });
      } else {
        _showError(model.message ?? "Unexpected response from server.");
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // ------------------- API 3: Get Category Level 3 -------------------
  Future<void> getCategoryThree(String level, String categoryId, int index) async {
    setState(() => isLoading = true);

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.getMenu);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {"level": level, "category_id": categoryId};
    final client = CustomHttpClient(http.Client());

    try {
      final response =
      await client.post(url, headers: headers, body: jsonEncode(requestBody));

      print('POST URL: $url');
      print('Response: ${response.body}');

      final model = CategoryResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        final categories = model.data?.category ?? [];
        if (categories.isEmpty) {
           Get.to(() => AllProductsScreen(categoryId: categoryId.toString()));

          return;
        }

        setState(() {
          sub_category_list
            ..clear()
            ..addAll(categories);
          expandedIndex = index; // ✅ correct tracking
        });
      } else {
        _showError(model.message ?? "Something went wrong.");
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // ------------------- Common Snackbar -------------------
  void _showError(String message) {
    Get.snackbar(
      "Menu",
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
  }
}
