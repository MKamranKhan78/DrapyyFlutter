import 'dart:convert';

import 'package:drapyy/activities/FilterScreen.dart';
import 'package:drapyy/activities/products_items/ProductByBrandLastItem.dart';
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
import 'LoginScreen.dart';
import 'NotificationsScreen.dart';
import 'ProductDetailsSccreen.dart';
import 'products_items/ProductItemAlt.dart';

class BranddetailsScreen extends StatefulWidget {
  final String brand_name;
  final String brand_Id;
  final String image_brand;

  BranddetailsScreen({super.key, required this.brand_name, required this.brand_Id, required this.image_brand});

  @override
  State<BranddetailsScreen> createState() => _BranddetailsScreenState();
}

class _BranddetailsScreenState extends State<BranddetailsScreen> {
  // State variables
  bool isLoading = false;
  bool isLoadingMore = false;

  String? is_followed = null;

  final List<BrandProductsLast> _products = [];
  final List<BrandCategoryLevel1Last> category = [];
  int selectedIndex = -1;
  List<int> sizesList_final = [];
  List<String> colorList_final = [];

  String minPrice_final = "";
  String maxPrice_final = "";
  String followers = "";
  String categor_IDD = "";

  // Pagination variables
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasMorePages = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getProductByBrand("1", "");

    // Add scroll listener for pagination
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (_hasMorePages && !isLoadingMore) {
        _loadMoreProducts();
      }
    }
  }

  void _loadMoreProducts() {
    if (_currentPage < _totalPages) {
      setState(() {
        isLoadingMore = true;
      });
      getProductByBrand((_currentPage + 1).toString(), categor_IDD.toString());
    }
  }

  void _resetPagination() {
    setState(() {
      _currentPage = 1;
      _totalPages = 1;
      _hasMorePages = true;
      _products.clear();
    });
  }


  String toTitleCase(String text) {
    if (text.isEmpty) return text;

    return text
        .trim()
        .split(RegExp(r'\s+')) // handles multiple spaces
        .map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    })
        .join(' ');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Brand",
                      style: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            Container(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black54,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            widget.image_brand.toString(),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.image, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          child: Text(
                            toTitleCase(widget.brand_name ?? ""),
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          followers.toString(),
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: grey,
                          ),
                        ),
                        Text(
                          "FOLLOWERS",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {

                          final skipValue = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST).toString();
                          if (skipValue == "1") {
                            Get.to(() => const LoginScreen());
                          } else {
                            syncFollowers(widget.brand_Id.toString());
                          }


                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Center(
                            child: Text(
                             // "Follow",
                              (is_followed != null && is_followed == "1") ? "Unfollow" : "Follow",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 20),
            _buildNavigationTabs(),
            Container(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      colorList_final.clear();
                      _navigateToFilterScreen();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      child: Center(
                        child: Text(
                          'FILTERS',
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 12,
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
            Container(height: 20),
            Expanded(
              child: _buildProductsGrid(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToFilterScreen() async {
    final result = await Get.to(() => FilterScreen());
    if (result != null) {
      String selected_color = result['colors'] ?? '';

      if (selected_color != "null") {
        colorList_final.clear();
        colorList_final.add(selected_color.toString());
      }

      sizesList_final.clear();
      sizesList_final.addAll(result['sizes']);

      minPrice_final = result['min_price'] ?? '0';
      maxPrice_final = result['max_price'] ?? '25000';

      print('Colors: $colorList_final');
      print('Sizes: $sizesList_final');
      print('minPrice: $minPrice_final');
      print('maxPrice: $maxPrice_final');

      // Reset pagination when filters change
      _resetPagination();
      getProductByBrand("1", "");
    }
  }

  Widget _buildNavigationTabs() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                categor_IDD = category[index].id.toString();
                // Reset pagination when category changes
                _resetPagination();
                getProductByBrand("1", categor_IDD.toString());
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    category[index].name.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? colorPrimary : black_color,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 2,
                      width: 30,
                      color: colorPrimary,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid() {
    if (_products.isEmpty && isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_products.isEmpty) {
      return const Center(
        child: Text(
          "No products found",
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: _products.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _products.length && isLoadingMore) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return ProductByBrandLastItem(
                  product: _products[index],
                  onItemClick: () {
                    Get.to(() => ProductDetailsSccreen(productId: _products[index].id.toString()));
                  },
                  onFavoriteClick: (newWishlistValue) async {
                    final skipValue = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST).toString();
                    if (skipValue == "1") {
                      Get.to(() => const LoginScreen());
                    } else {
                      addRemoveWishlist(_products[index].id.toString());
                    }
                  },
                );
              },
            ),
          ),
          if (isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future<void> addRemoveWishlist(String id) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.syncWishlist);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
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

      final model = WishlistResponse.fromJson(json.decode(response.body));

      if (model.status == 1) {
        eventBus.fire(FavUpdatedEvent(model.data.count.toString()));
        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getProductByBrand("1", categor_IDD.toString());
      } else if (model.status == 2) {
        eventBus.fire(FavUpdatedEvent(model.data.count.toString()));
        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getProductByBrand("1", categor_IDD.toString());
      } else if (model.status == 0 || model.status == 401 || model.status != null) {
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

  Future<void> syncFollowers(String brandId) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.sync_my_follows);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {
      "brand_id": brandId.toString(),
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

      final model = PlaceOrderResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        Get.snackbar(
          "Follow",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        _resetPagination();
        getProductByBrand("1", "");

      } else if (model.status == 0 || model.status == 401 || model.status != null) {
        Get.snackbar(
          "Follow",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Follow",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Follow",
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

  Future<void> getProductByBrand(String currentPage, String category_id) async {
    // If loading more, set loadingMore to true, otherwise set isLoading to true
    if (currentPage != "1") {
      setState(() {
        isLoadingMore = true;
      });
    } else {
      setState(() {
        isLoading = true;
      });
    }

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.productByBroand);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {
      "brand": widget.brand_name.toString(),
      "per_page": "10",
      "current_page": currentPage.toString(),
      "category_level1_id": category_id.toString(),
      if (sizesList_final.isNotEmpty) "sizes": sizesList_final,
      if (colorList_final.isNotEmpty) "colors": colorList_final,
      if (minPrice_final.isNotEmpty && maxPrice_final.isNotEmpty && !(minPrice_final == "0" && maxPrice_final == "25000")) ...{
        "from": minPrice_final,
        "to": maxPrice_final,
      },
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

      final model = BrandGetProductByBrandLast.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          followers = model.data!.followers.toString();
          _currentPage = model.data!.currentPage ?? 1;


          print("BD---->---IS_FOLLOWED------->"+model.data!.brand!.is_followed.toString());

          if(model.data!.brand!.is_followed != null && model.data!.brand!.is_followed.toString().isNotEmpty){
            is_followed = model.data!.brand!.is_followed.toString();
          }else{
            is_followed = "0";
          }

          print("IS_FOLLOWED------>"+model.data!.brand!.is_followed.toString());
          _totalPages = model.data!.totalPages ?? 1;
          _hasMorePages = model.data!.hasMorePage ?? false;

          if (currentPage == "1") {
            // First page - replace all products
            _products.clear();
            _products.addAll(model.data!.products as Iterable<BrandProductsLast>);
          } else {
            // Subsequent pages - append products
            _products.addAll(model.data!.products as Iterable<BrandProductsLast>);
          }

          if (model.data!.categoryLevel1!.length > 0) {
            category.clear();
            category.addAll(model.data!.categoryLevel1 as Iterable<BrandCategoryLevel1Last>);
          }
        });
      } else if (model.status == 0 || model.status == 401 || model.status != null) {
        Get.snackbar(
          "Brand",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Brand",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Brand",
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
          isLoadingMore = false;
        });
      }
    }
  }
}











/*




import 'dart:convert';

import 'package:drapyy/activities/FilterScreen.dart';
import 'package:drapyy/activities/products_items/ProductByBrandLastItem.dart';
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
import 'LoginScreen.dart';
import 'NotificationsScreen.dart';
import 'ProductDetailsSccreen.dart';
import 'products_items/ProductItemAlt.dart';

class BranddetailsScreen extends StatefulWidget {
   final String brand_name;
   final String brand_Id;
   final String image_brand;

   BranddetailsScreen({super.key , required this.brand_name, required this.brand_Id, required this.image_brand});



  @override
  State<BranddetailsScreen> createState() => _BranddetailsScreenState();
}

class _BranddetailsScreenState extends State<BranddetailsScreen> {
  // State variables
  bool isLoading = false;

  final List<BrandProductsLast> _products = [];
  final List<BrandCategoryLevel1Last> category = [];
  int selectedIndex = -1;
  List<int> sizesList_final = [];
  List<String> colorList_final = [];

  String minPrice_final = "";
  String maxPrice_final = "";
  String followers = "";
  String categor_IDD = "";


  @override
  void initState() {
    super.initState();
    getProductByBrand("1","");
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [

                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,),
                  onPressed: () {
                     Get.back();
                  },
                ),
                // Expanded makes the Text take remaining space and stay centered
                Expanded(
                  child: Center(
                    child: Text(
                      "Brand", // 👈 your text here
                      style: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // same width as IconButton

              ],
            ),


            Container(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        width: 80, // diameter (2 × radius)
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black54, // 👈 border color
                            width: 2, // 👈 border thickness
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            widget.image_brand.toString(),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.image, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Container(
                          width: 150,
                          child: Text(
                              ""+widget.brand_name.toString(),
                              style: TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 14,
                                fontWeight:FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                        ),
                        Text(
                            followers.toString(),
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: grey,
                            ),
                          ),
                        Text(
                          "FOLLOWERS",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            fontWeight:FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          syncFollowers(widget.brand_Id.toString());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Center(
                            child: Text(
                              'FOLLOW',
                              style: TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 10, // Slightly smaller for grid layout
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


              ],
            ),
            // Profile Image







            Container(height: 20,),
            // Navigation Tabs
            _buildNavigationTabs(),
            Container(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      colorList_final.clear();
                      _navigateToFilterScreen();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      child: Center(
                        child: Text(
                          'FILTERS',
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

            Container(height: 20,),
            // Products Grid
            Expanded(
              child: _buildProductsGrid(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToFilterScreen() async {
     final result = await Get.to(() => FilterScreen());
     if (result != null) {

      String selected_color = result['colors'] ?? '';

      if(selected_color != "null"){
        colorList_final.clear();
        colorList_final.add(selected_color.toString());
      }

      sizesList_final.clear();
      sizesList_final.addAll(result['sizes']);

      minPrice_final = result['min_price'] ?? '0';
      maxPrice_final = result['max_price'] ?? '25000';


      // Use the received data
      print('Colors: $colorList_final');
      print('Sizes: $sizesList_final');
      print('minPrice: $minPrice_final');
      print('maxPrice: $maxPrice_final');


      getProductByBrand("1", "");

    }
  }


  Widget _buildNavigationTabs() {
    return SizedBox(
        height: 40,
        child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) {
        final isSelected = index == selectedIndex;

      return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
            print("CLICKEDDDD"+category[index].id.toString());
            categor_IDD= category[index].id.toString();
            getProductByBrand("1", categor_IDD.toString());
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category[index].name.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? colorPrimary : black_color,
                ),
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4), // space between text & underline
                  height: 2,
                  width: 30, // underline length (you can adjust or use text width)
                  color: colorPrimary,
                ),
            ],
          ),
        )
      );
    },
    ),);
  }


  Widget _buildProductsGrid() {
    if (_products.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.7,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductByBrandLastItem(
            product: _products[index],
            onItemClick: () {
              Get.to(() => ProductDetailsSccreen(productId: _products[index].id.toString()));
            },
            onFavoriteClick: (newWishlistValue) async {
              final skipValue = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST).toString();
              if (skipValue == "1") {
                Get.to(() => const LoginScreen());
              } else {
                addRemoveWishlist(_products[index].id.toString());
              }
            },
          );
        },
      ),
    );
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
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getProductByBrand("1",categor_IDD.toString());
       }else if (model.status == 2) {
        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getProductByBrand("1",categor_IDD.toString());
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



  Future<void> syncFollowers(String brandId) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.sync_my_follows);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "brand_id": brandId.toString(),
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



  Future<void> getProductByBrand(String currentPage,String category_id) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.productByBroand);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "brand": widget.brand_name.toString(),
      "per_page": "10",
      "current_page": currentPage.toString(),
      "category_level1_id": category_id.toString(),
      if (sizesList_final.isNotEmpty) "sizes": sizesList_final, // ✅ only added if not empty
      if (colorList_final.isNotEmpty) "colors": colorList_final, // ✅ only added if not empty
      if (minPrice_final.isNotEmpty &&
          maxPrice_final.isNotEmpty &&
          !(minPrice_final == "0" && maxPrice_final == "25000")) ...{
        "from": minPrice_final,
        "to": maxPrice_final,
      },
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
      BrandGetProductByBrandLast.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {

          followers = model.data!.followers.toString();

          if(model.data!.products!.length >0){
            _products.clear();
            _products.addAll(model.data!.products as Iterable<BrandProductsLast>);
          }

          if(model.data!.categoryLevel1!.length > 0){
            category.clear();
            category.addAll(model.data!.categoryLevel1 as Iterable<BrandCategoryLevel1Last>);
          }


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


}*/
