import 'dart:convert';

import 'package:drapyy/activities/CheckoutPage.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart'; // Add this import

import '../activities/LoginScreen.dart';
import '../activities/PrivacyPolicyScreen.dart';
import '../activities/TermsAndConditionScreen.dart';
import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/colors.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';

// Cart Screen
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;
  bool isFirstLoad = true; // Track first time loading
  List<Cartt> cart_list = [];
  String discount = "";
  String grossTotal = "";
  String grandTotal = "";

  @override
  void initState() {
    super.initState();
    getAllCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // Shopping Cart Title
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 15),
                    child: Text(
                      "SHOPPING CART",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Show shimmer only for first load when cart is empty
                  if (isFirstLoad && cart_list.isEmpty)
                    _buildShimmerCartItems()
                  else if (cart_list.length > 0)
                    _buildCartItems()
                  else
                    _buildEmptyCart(),

                  // Summary Section
                  if (!isFirstLoad || cart_list.isNotEmpty)
                    _buildSummarySection(),

                  // Footer Section
                  if (!isFirstLoad || cart_list.isNotEmpty)
                    _buildFooterSection(),
                ],
              ),
            ),

            // Show loading indicator only for subsequent operations (not first load)
            if (isLoading && !isFirstLoad)
              Center(
                child: CircularProgressIndicator(),
              )
          ],
        )
    );
  }

  // Shimmer effect for cart items
  Widget _buildShimmerCartItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3, // Show 3 shimmer items
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                Container(
                  width: 80,
                  height: 100,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                // Content placeholder
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Remove
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            height: 16,
                            color: Colors.white,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Size and Color
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 50,
                            height: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 20),
                          Container(
                            width: 40,
                            height: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 50,
                            height: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Price and Quantity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 16,
                            color: Colors.white,
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Actual cart items
  Widget _buildCartItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: cart_list.length,
      itemBuilder: (context, index) {
        final item = cart_list[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.product!.imageUrl ?? '',
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      Drawables.img_logo,
                      width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Remove
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cart_list[index].product!.name.toString() ?? "",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            removeFromCart(item.id.toString());
                          },
                          child: Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Text(
                          "Size:",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(width: 10),
                        Text(
                          cart_list[index].product!.variant!.sizeName.toString(),
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),

                        Container(width: 20),
                        Text(
                          "Color:",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(width: 10),
                        Text(
                          cart_list[index].product!.variant!.colorName.toString(),
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (cart_list[index].product!.variant!.offerPrice != null &&
                                cart_list[index].product!.variant!.offerPrice != "null" &&
                                cart_list[index].product!.variant!.offerPrice!.isNotEmpty)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "PKR ${cart_list[index].product!.variant!.offerPrice}",
                                    style: const TextStyle(
                                      fontFamily: FontConstants.gothamPro,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "PKR ${cart_list[index].product!.variant!.price}",
                                    style: const TextStyle(
                                      fontFamily: FontConstants.gothamPro,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 1.5,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                "PKR ${cart_list[index].product!.variant!.price ?? ''}",
                                style: const TextStyle(
                                  fontFamily: FontConstants.gothamPro,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                          ],
                        ),

                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      int currentQty = item.quantity ?? 0;
                                      if (currentQty > 0) {
                                        currentQty--;
                                      }
                                      item.quantity = currentQty;
                                    });
                                    print('Quantity: ${item.quantity}');
                                    updateCart(item.id.toString(), item.quantity.toString());
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  (item.quantity ?? 0).toString(),
                                  style: const TextStyle(
                                    fontFamily: FontConstants.gothamPro,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      int currentQty = item.quantity ?? 0;
                                      currentQty++;
                                      item.quantity = currentQty;
                                    });
                                    print('Quantity: ${item.quantity}');
                                    updateCart(item.id.toString(), item.quantity.toString());
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Empty cart widget
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        children: [
          Container(height: 50),
          Text(
            "Cart is empty",
            style: TextStyle(
              fontFamily: FontConstants.gothamPro,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: sky_grey_dark,
            ),
          ),
          Container(height: 50),
        ],
      ),
    );
  }

  // Summary section
  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          _summaryRow("Discount", discount.toString()),
          _summaryRow("Total Price", grossTotal.toString()),
          _summaryRow("Estimated delivery fees", "Free"),
          const Divider(),
          _summaryRowBig("TOTAL", grandTotal.toString()),
          const SizedBox(height: 8),
          _summaryRow("SAVING APPLIED", discount.toString()),
          const SizedBox(height: 16),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              child: InkWell(
                onTap: () {
                  final skipValue = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST).toString();
                  if (skipValue == "1") {
                    Get.to(() => const LoginScreen());
                  } else {
                    if (cart_list.length > 0) {
                      Get.to(() => const CheckoutPage());
                    } else {
                      Get.snackbar(
                        "Cart",
                        "Add products to checkout",
                        backgroundColor: Colors.black,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(10),
                        duration: const Duration(seconds: 2),
                      );
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "CHECKOUT NOW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: FontConstants.gothamPro,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Image.asset(
                      Drawables.arrow_farward,
                      width: 25,
                      height: 25,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Footer section
  Widget _buildFooterSection() {
    return Column(
      children: [
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
                      _launchSocialLink(
                        PreferenceManager.getString(
                          NetworkManager.PREF_INSTAGRAM,
                        ).toString(),
                      );
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
                      _launchSocialLink(
                        PreferenceManager.getString(
                          NetworkManager.PREF_FACEBOOK,
                        ).toString(),
                      );
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
                      _launchSocialLink(
                        PreferenceManager.getString(
                          NetworkManager.PREF_YOUTUBE,
                        ).toString(),
                      );
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
        ),
      ],
    );
  }

  // Rest of your existing methods (_launchSocialLink, _summaryRow, _summaryRowBig, getAllCarts, removeFromCart, updateCart)
  // ... keep all your existing methods as they are

  Future<void> _launchSocialLink(String url) async {
    Uri uri = Uri.parse(url);

    // Try native deep links for known apps
    if (url.contains('facebook.com')) {
      final fbAppUrl = Uri.parse('fb://facewebmodal/f?href=$url');
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

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: FontConstants.gothamPro,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: sky_grey_dark,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: FontConstants.gothamPro,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: sky_grey_dark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRowBig(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: FontConstants.gothamPro,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: app_color_black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: FontConstants.gothamPro,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: app_color_black,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getAllCarts() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.cart);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final client = CustomHttpClient(http.Client());

    try {
      final response = await client.get(url, headers: headers);

      print('POST URL: $url');
      print('Request Headers: $headers');
      print('Response Code: ${response.statusCode}');
      print(
        "-------------------------------------FULL RESPONSE-------------------------------------",
      );
      Toastutils.printFullText(response.body.toString());
      print(
        "-------------------------------------------------------------------------------------",
      );
      final model = GetAllCartsResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          if (model.data!.carts!.length > 0) {
            cart_list.clear();
            cart_list.addAll(model.data!.carts as Iterable<Cartt>);
          }

          if (model.data!.calculations != null) {
            discount = model.data!.calculations!.discountt.toString();
            grossTotal = model.data!.calculations!.grossTotal.toString();
            grandTotal = model.data!.calculations!.grandTotal.toString();
          }
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Cart",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
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
          model.message.toString(),
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
          isFirstLoad = false; // Mark first load as complete
        });
      }
    }
  }

  Future<void> removeFromCart(String id) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.cartRemove);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {"id": id.toString()};

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
        "-------------------------------------FULL RESPONSE-------------------------------------",
      );
      Toastutils.printFullText(response.body.toString());
      print(
        "-------------------------------------------------------------------------------------",
      );

      final model = BrandGetProductByBrand.fromJson(json.decode(response.body));

      if (model.status == 1) {
        Get.snackbar(
          "Cart",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getAllCarts();
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

  Future<void> updateCart(String id, String quantity) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.cartUpdate);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {"id": id.toString(), "quantity": quantity.toString()};

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
        "-------------------------------------FULL RESPONSE-------------------------------------",
      );
      Toastutils.printFullText(response.body.toString());
      print(
        "-------------------------------------------------------------------------------------",
      );

      final model = UpdateCartResponse.fromJson(json.decode(response.body));

      if (model.status == 1) {
        Get.snackbar(
          "Cart",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getAllCarts();
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