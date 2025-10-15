import 'dart:convert';

import 'package:drapyy/models/Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../activities/LoginScreen.dart';
import '../activities/ProductDetailsSccreen.dart';
import '../activities/products_items/HomeCategoryProductItem.dart';
import '../activities/products_items/HomeProductItem.dart';
import '../activities/products_items/ProductItemAlt.dart';
import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/colors.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../network/Network.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  bool isLoading = false;

  List<ProductHomee> products = [];


  @override
  void initState() {
     super.initState();
    getWishlist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return HomeProductItem(
                  product: products[index],
                  onItemClick: () {
                    Get.to(() => ProductDetailsSccreen(productId: products[index].id.toString()));
                  },
                  onFavoriteClick: (newWishlistValue) async {
                    final skipValue = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST).toString();
                    if (skipValue == "1") {
                      Get.to(() => const LoginScreen());
                    } else {
                      addRemoveWishlist(products[index].id.toString());
                    }
                  },
                );
              },
            ),
          ),
          if (isLoading)
            Container(
              child: const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      )
    );
  }


  Future<void> getWishlist() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.wishlist);
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
      final model = GetWishlistResponse.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          products.clear();
          products.addAll(model.data!.products as Iterable<ProductHomee>);
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

  Future<void> addRemoveWishlist(String id) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.syncWishlist);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "id": id.toString(),
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
        getWishlist();
      }else if (model.status == 2) {
        Get.snackbar(
          "Status ${model.status}",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getWishlist();
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
