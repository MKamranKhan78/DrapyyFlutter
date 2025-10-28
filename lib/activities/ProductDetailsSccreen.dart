import 'dart:async';
import 'dart:convert';

import 'package:drapyy/activities/products_items/DetailProductItem.dart';
import 'package:drapyy/activities/products_items/HomeCategoryProductItem.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/drawables.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';
import 'LoginScreen.dart';
import 'PrivacyPolicyScreen.dart';
import 'TermsAndConditionScreen.dart';
import 'products_items/ProductItemAlt.dart';

class ProductDetailsSccreen extends StatefulWidget {
  final String productId; // 👈 parameter

  ProductDetailsSccreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailsSccreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailsSccreen> {
  List<ProductHomee> product_list = [];

  String? _selectedSize; // keep as-is (this will store sizeName)
  List<DetailSizes> size_list = []; // your API-loaded list

  String? _selectedColor; // store selected color id or index
  List<DetailColors> color_list = []; // populated from API
  String variation_iddd = "";

  bool isLoading = false;
  bool _isFirstLoad = true; // Track first load for shimmer

  final PageController _pageController = PageController();
  List<String> banners_list = [];
  int _currentPage = 0;
  Timer? _timer;

  String product_offer_price = "";
  String product_price = "";
  String product_name = "";
  String product_description = "";
  String product_summary = "";

  @override
  void initState() {
    super.initState();
    getProductDetails(widget.productId.toString());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isFirstLoad && isLoading
            ? _buildShimmerEffect()
            : _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Section
          Stack(
            children: [
              SizedBox(
                height: 350,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: banners_list.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.network(
                      banners_list[index].toString(),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.broken_image,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),

          // Product Details Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Price
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product_name.toString(),
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: grey,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ✅ If offerPrice exists — show discounted and struck-out price
                        if (product_offer_price.isNotEmpty &&
                            product_offer_price != "null")
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "PKR ${product_offer_price}",
                                style: const TextStyle(
                                  fontFamily: FontConstants.gothamPro,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "PKR ${product_price}",
                                style: const TextStyle(
                                  fontFamily: FontConstants.gothamPro,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 1.5,
                                ),
                              ),
                            ],
                          )
                        else
                        // ✅ Show only the actual price when no offer
                          Text(
                            "PKR ${product_price ?? ''}",
                            style: const TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    // Size Section
                    Text(
                      'Size',
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 12,
                      children: size_list.asMap().entries.map((entry) {
                        final index = entry.key;
                        final detailSize = entry.value;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSize = detailSize.sizeName;
                              getColorBySize(detailSize.productId.toString(),
                                  detailSize.id.toString());
                            });
                          },
                          child: Container(
                            width:
                            24, // slightly smaller for tighter spacing
                            height: 24,
                            decoration: BoxDecoration(
                              color: _selectedSize == detailSize.sizeName
                                  ? Colors.black
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 0.6, // thinner border line
                              ),
                            ),
                            child: Center(
                              child: Text(
                                detailSize.sizeName ?? '',
                                style: TextStyle(
                                  fontFamily: FontConstants.gothamPro,
                                  fontSize: 10, // increased text size
                                  fontWeight: FontWeight.bold,
                                  color: _selectedSize == detailSize.sizeName
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Container(width: 20),

                    // Color Section
                    Text(
                      'Color',
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Container(width: 10),
                    Row(
                      children: color_list.asMap().entries.map((entry) {
                        final index = entry.key;
                        final colorItem = entry.value;

                        // Parse hex color safely
                        Color parsedColor = Colors.grey; // fallback
                        try {
                          if (colorItem.hexCode != null &&
                              colorItem.hexCode!.isNotEmpty) {
                            parsedColor = Color(int.parse(colorItem.hexCode!
                                .replaceAll('#', '0xFF')));
                          }
                        } catch (_) {}

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = colorItem.id?.toString();
                              variation_iddd = colorItem.id.toString();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets
                                .all(2), // 👈 space between border and circle
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: _selectedColor == colorItem.id.toString()
                                  ? Border.all(color: searchtxtcolor, width: 2)
                                  : null,
                            ),
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: parsedColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Add to Cart Button
              InkWell(
                onTap: () {
                  print("VERIATION_ID------>" + variation_iddd.toString());
                  addToCart(variation_iddd.toString());
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Description Section
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 25),
                child: Text(
                  'DESCRIPTION',
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding:
                const EdgeInsets.only(left: 15.0, top: 10, right: 15),
                child: Text(
                  product_description.toString(),
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),

              // Summary Section
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 25),
                child: Text(
                  'SUMMARY',
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding:
                const EdgeInsets.only(left: 15.0, top: 10, right: 15),
                child: Text(
                  product_summary.toString(),
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Align(
                alignment: Alignment.center,
                child: Text(
                  'SIMILAR ITEMS',
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: product_list.length,
                  itemBuilder: (context, index) {
                    return DetailProductItem(
                      product: product_list[index],
                      onItemClick: () {
                        Get.to(() => ProductDetailsSccreen(
                            productId: product_list[index].id.toString()));
                      },
                      onFavoriteClick: (newWishlistValue) async {
                        final skipValue = PreferenceManager.getString(
                            NetworkManager.PREF_IS_GUEST)
                            .toString();
                        if (skipValue == "1") {
                          Get.to(() => const LoginScreen());
                        } else {
                          addRemoveWishlist(product_list[index].id.toString());
                        }
                      },
                    );
                  },
                ),
              ),

              Container(height: 30),
              Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 20),
                    Image.asset(
                      Drawables.new_drappy_image,
                      width: 250,
                      height: 250,
                    ),

                    Container(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print("INSTAGRAM clicked");
                            print(PreferenceManager.getString(
                                NetworkManager.PREF_INSTAGRAM)
                                .toString());
                            _launchSocialLink(PreferenceManager.getString(
                                NetworkManager.PREF_INSTAGRAM)
                                .toString());
                            // 👉 Add navigation or link open here
                          },
                          child: Text(
                            "INSTAGRAM",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("FACEBOOK clicked");
                            print(PreferenceManager.getString(
                                NetworkManager.PREF_FACEBOOK)
                                .toString());
                            _launchSocialLink(PreferenceManager.getString(
                                NetworkManager.PREF_FACEBOOK)
                                .toString());
                          },
                          child: Text(
                            "FACEBOOK",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("YOUTUBE clicked");

                            _launchSocialLink(PreferenceManager.getString(
                                NetworkManager.PREF_YOUTUBE)
                                .toString());
                          },
                          child: Text(
                            "YOUTUBE",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(height: 40),
                    Container(width: 300, height: 1, color: Colors.grey),
                    Container(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print("PRIVACY POLICY clicked");
                            Get.to(Privacypolicyscreen());
                          },
                          child: Text(
                            "PRIVACY POLICY",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          "/",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("TERMS OF USE clicked");
                            Get.to(Termsandconditionscreen());
                          },
                          child: Text(
                            "TERMS OF USE",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for Image Section
          Stack(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 350,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Shimmer for Product Details
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 200,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100,
                    height: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Shimmer for Size and Color Section
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 40,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Wrap(
                  spacing: 6,
                  children: List.generate(4, (index) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )),
                ),
                Container(width: 20),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 40,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
                Container(width: 10),
                Row(
                  children: List.generate(3, (index) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(right: 6),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Shimmer for Add to Cart Button
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.white,
            ),
          ),

          // Shimmer for Description
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 25),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 120,
                height: 16,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15),
            child: Column(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 12,
                    color: Colors.white,
                  ),
                ),
              )),
            ),
          ),

          // Shimmer for Summary
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 25),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 100,
                height: 16,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15),
            child: Column(
              children: List.generate(2, (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 12,
                    color: Colors.white,
                  ),
                ),
              )),
            ),
          ),

          const SizedBox(height: 30),

          // Shimmer for Similar Items Header
          Align(
            alignment: Alignment.center,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 150,
                height: 16,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Shimmer for Similar Items Grid
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(height: 30),

          // Shimmer for Footer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.black,
              height: 400,
              width: double.infinity,
            ),
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
        getProductDetails(widget.productId.toString());
      }else if (model.status == 2) {
        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getProductDetails(widget.productId.toString());
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

  Future<void> _launchSocialLink(String url) async {
    Uri uri = Uri.parse(url);

    // Try native deep links for known apps
    if (url.contains('facebook.com')) {
      final fbAppUrl =
      Uri.parse('fb://facewebmodal/f?href=$url');
      if (await canLaunchUrl(fbAppUrl)) {
        await launchUrl(fbAppUrl, mode: LaunchMode.externalApplication);
        return;
      }
    } else if (url.contains('instagram.com')) {
      final username = url.split('/').where((s) => s.isNotEmpty).last;
      final instaAppUrl = Uri.parse('instagram://user?username=$username');
      if (await canLaunchUrl(instaAppUrl)) {
        await launchUrl(instaAppUrl, mode: LaunchMode.externalApplication);
        return;
      }
    } else if (url.contains('youtube.com')) {
      final ytAppUrl = Uri.parse('youtube://$url');
      if (await canLaunchUrl(ytAppUrl)) {
        await launchUrl(ytAppUrl, mode: LaunchMode.externalApplication);
        return;
      }
    }

    // Fallback to browser if native app not available
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < banners_list.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> getProductDetails(String id) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.product_details);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "product_id": id.toString(),
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
      DetailProductDetailsModel.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          banners_list.clear();
          banners_list.addAll(model.data!.product!.imagesUrl as Iterable<String>);
          _startAutoSlide();

          product_price = model.data!.product!.variant!.price.toString();
          product_offer_price = model.data!.product!.variant!.offerPrice.toString();

          product_name = model.data!.product!.name.toString();
          product_description = model.data!.product!.description.toString();
          product_summary = model.data!.product!.summary.toString();

          product_list.clear();
          product_list.addAll(model.data!.similarProducts as Iterable<ProductHomee>);

          if(model.data!.sizes!.length > 0){
            variation_iddd = model.data!.colors![0].id.toString();
            size_list.clear();
            size_list.addAll(model.data!.sizes as Iterable<DetailSizes>);
          }

          if(model.data!.colors!.length > 0){
            color_list.clear();
            color_list.addAll(model.data!.colors as Iterable<DetailColors>);
            _selectedColor = color_list.first.id?.toString();
          }

          if (model.data!.sizes!.length == 0 && model.data!.colors!.length ==0){
            variation_iddd = model.data!.product!.variant!.id.toString();
          }

          _isFirstLoad = false; // Disable shimmer after first successful load
        });
      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
        Get.snackbar(
          "Product Details",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Product Details",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      print("ERROR-------------->"+e.toString());
      Get.snackbar(
        "Product Details",
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

  Future<void> getColorBySize(
      String product_id,
      String variation_id,
      ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.productColor);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "product_id": product_id.toString(),
      "variation_id": variation_id.toString(),
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
      ColorsResponsee.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          if(model.data!.colors!.length > 0){
            variation_iddd = model.data!.colors![0].id.toString();
            color_list.clear();
            color_list.addAll(model.data!.colors as Iterable<DetailColors>);
          }
        });
      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
        Get.snackbar(
          "Product Color",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Product Color",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Product Color",

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

  Future<void> addToCart(String variation_id) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.addCart);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "variation_id": variation_id.toString(),
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
      BrandGetProductByBrand.fromJson(json.decode(response.body));

      if (model.status == 1) {
        Get.snackbar(
          "Cart",
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
          "Cart",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Cart",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Cart",
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