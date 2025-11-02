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
  bool isFirstLoad = true; // Track first time loading
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
          // Show shimmer effect only during first load
          if (isFirstLoad && isLoading)
            _buildShimmerEffect()
          else if (products.isEmpty && !isLoading)
            _buildEmptyState()
          else
            _buildProductGrid(),

          // Show loading indicator only for subsequent loads (not first time)
          if (!isFirstLoad && isLoading)
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
      ),
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 15, top: 10),
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
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 15, top: 10),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.7,
        ),
        itemCount: 6, // Show 6 shimmer items
        itemBuilder: (context, index) {
          return _buildShimmerItem();
        },
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),

          // Content area
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),

                // Price placeholder
                Container(
                  height: 14,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),

                // Button placeholder
                Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items you love to your wishlist',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
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
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Wishlist",
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
          isFirstLoad = false; // Mark first load as complete
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
      print("-------------------------------------FULL RESPONSE-------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");

      final model = AddWishlistModell.fromJson(json.decode(response.body));

      if (model.status == 1) {
        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getWishlist();
      } else if (model.status == 2) {
        Get.snackbar(
          "Wishlist",
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
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Wishlist",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Wishlist",
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