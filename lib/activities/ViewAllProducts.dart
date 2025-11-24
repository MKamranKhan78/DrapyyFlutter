import 'dart:convert';

import 'package:drapyy/activities/products_items/SearchProductItemAlt.dart';
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
import 'ProductDetailsSccreen.dart';

class ViewAllProducts extends StatefulWidget {


  @override
  State<ViewAllProducts> createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends State<ViewAllProducts> {
  // State variables
  bool isLoading = false;
  bool isLoadingMore = false; // For pagination loading

  List<PBBSizes> size_list = [];
  List<int> selectedIndexes = []; // ✅ Multiple selections, empty by default

  List<PBBColors> color_list = [];
  PBBColors? selectedColor; // selected color object
  int? selectedColorId; // store selected color id

  List<CategoryProductHomee> _products = [];
  List<String> colorListSend = [];

  // Pagination variables
  int _currentPage = 1;
  bool _hasMorePages = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getSizeAndColor();
    _resetPaginationAndSearch();
    _setupScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreProducts();
      }
    });
  }

  void _resetPaginationAndSearch() {
    setState(() {
      _currentPage = 1;
      _hasMorePages = true;
      _products.clear();
    });
    serachItem("", "10", "1");
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
                // Expanded makes the Text take remaining space and stay centered
                Expanded(
                  child: Center(
                    child: Text(
                      "Products", // 👈 your text here
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
            // Navigation Tabs
            _buildNavigationTabs(),
            Container(height: 10,),

            // Color Row (Text + Dropdown)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Color",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16, // reduced
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DropdownButton<PBBColors>(
                    value: selectedColor,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                    underline: const SizedBox(), // hide underline
                    hint: const Text(
                      "Select Color",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    items: color_list.map((PBBColors value) {
                      return DropdownMenuItem<PBBColors>(
                        value: value,
                        child: Text(
                          value.color ?? "Unknown",
                          style: const TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedColor = val;
                        selectedColorId = val?.id; // ✅ get color id here
                      });
                      debugPrint("Selected Color ID: ${selectedColorId}");
                      _resetPaginationAndSearch();
                    },
                  ),
                ],
              ),
            ),

            Container(height: 20,),
            // Products Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildProductsGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: size_list.length,
          itemBuilder: (context, index) {
            final isSelected = selectedIndexes.contains(index);
            final item = size_list[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedIndexes.remove(index);
                  } else {
                    selectedIndexes.add(index);
                  }
                  _resetPaginationAndSearch();
                  print("SELECTED SIZES ---> ${selectedIndexes.map((i) => size_list[i].id).toList()}");
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    item.size.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    if (isLoading && _products.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_products.isEmpty && !isLoading) {
      return const Center(
        child: Text(
          "No data found",
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: _products.length + (_hasMorePages ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _products.length && _hasMorePages) {
                  return _buildLoadingIndicator();
                }
                return SearchProductItemAlt(
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
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 100,
      child: Center(
        child: isLoadingMore
            ? const CircularProgressIndicator()
            : Container(), // Empty container when not loading more
      ),
    );
  }

  void _loadMoreProducts() {
    if (!isLoadingMore && _hasMorePages) {
      setState(() {
        isLoadingMore = true;
      });
      _currentPage++;
      serachItem("", "10", _currentPage.toString());
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
      WishlistResponse.fromJson(json.decode(response.body));

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
        _resetPaginationAndSearch();
      }else if (model.status == 2) {
        eventBus.fire(FavUpdatedEvent(model.data.count.toString()));

        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        _resetPaginationAndSearch();
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

  Future<void> getSizeAndColor() async {
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
      "brand": "khazanatul-malabis",
      "per_page": "2",
      "current_page": "1",
      "category_level1_id": "",
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
      PBBGetProductByBrand.fromJson(json.decode(response.body));

      if (model.status == 1) {
        if(model.data!.sizes!.length > 0){
          size_list.clear();
          size_list.addAll(model.data!.sizes as Iterable<PBBSizes>);
        }

        if(model.data!.colors!.length > 0){
          color_list.clear();
          color_list.addAll(model.data!.colors as Iterable<PBBColors>);
        }


      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
        Get.snackbar(
          "Colors",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Colors",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Colors",
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

  Future<void> serachItem(
      String search,
      String per_page,
      String current_page
      ) async {
    final isFirstPage = current_page == "1";

    if (isFirstPage) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isLoadingMore = true;
      });
    }

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.search);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    if(selectedColorId != null){
      colorListSend.clear();
      colorListSend.add(selectedColorId.toString());
    }

    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "search": search.toString(),
      "per_page": per_page.toString(),
      "current_page": current_page.toString(),
      if (selectedIndexes.isNotEmpty) "sizes": selectedIndexes,
      if (colorListSend.isNotEmpty) "colors": colorListSend,
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
      ProductResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        if (isFirstPage) {
          _products.clear();
          _products.addAll(model.data!.products as Iterable<CategoryProductHomee>);
        } else {
          _products.addAll(model.data!.products as Iterable<CategoryProductHomee>);
        }

        // Update pagination state
        setState(() {
          _hasMorePages = model.data?.hasMorePage ?? false;
          _currentPage = int.tryParse(current_page) ?? 1;
        });

      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
        Get.snackbar(
          "Search",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Search",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Search",

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

