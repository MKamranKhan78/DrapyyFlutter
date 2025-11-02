import 'dart:async';
import 'dart:convert';
import 'package:drapyy/activities/BrandDetailsScreen.dart';
import 'package:drapyy/activities/LoginScreen.dart';
import 'package:drapyy/activities/PrivacyPolicyScreen.dart';
import 'package:drapyy/activities/TermsAndConditionScreen.dart';
import 'package:drapyy/activities/products_items/HomeCategoryProductItem.dart';
import 'package:drapyy/activities/ProductDetailsSccreen.dart';
import 'package:drapyy/activities/products_items/HomeProductItem.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:drapyy/models/Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

import '../activities/products_items/ProductItemAlt.dart';
import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../network/Network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  bool isLoading = false;
  bool _isFirstLoad = true; // 👈 New flag to track first load

  List<CategoryProductHomee> category_product_list = [];
  List<BannerHomee> banners_list = [];
  List<CategoryHomee> category_list = [];
  List<PartnerHomee> partner_list = [];
  List<ProductHomee> product_list = [];
  int? selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    checkGuestStatus();
  }

  Future<void> checkGuestStatus() async {
    print("HOME_checkGuestStatus------------>");
    String isGuest = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST)?.toString() ?? "";
    if (isGuest.isNotEmpty) {
      print("HOME_checkGuestStatus------------1>-------isGuest--->"+isGuest.toString());
      if (isGuest == "0") {
        print("HOME_checkGuestStatus------------2>");
        getHome();
      } else {
        print("HOME_checkGuestStatus------------3>");
        guestSignup("sdhfjdshfjhsd j fhdsjgf hsgdhfgshdghf gdshgf hsdg fsd");
      }
    } else {
      print("HOME_checkGuestStatus------------4>");
      guestSignup("sdhfjdshfjhsd j fhdsjgf hsgdhfgshdghf gdshgf hsdg fsd");
    }
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

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: 2,
      height: isActive ? 70 : 40,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  // 👇 Shimmer Widgets
  Widget _buildBannerShimmer() {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIndicatorShimmer() {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
              (index) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: 2,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 200,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildCategoryListShimmer() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 60,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    width: 40,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGridShimmer() {
    return Padding(
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
    );
  }

  Widget _buildBrandsGridShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: 6,
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
    );
  }

  Widget _buildHorizontalProductsShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmailFieldShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterShimmer() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 40),
          Shimmer.fromColors(
            baseColor: Colors.grey[700]!,
            highlightColor: Colors.grey[500]!,
            child: Container(
              width: 200,
              height: 100,
              color: Colors.white,
            ),
          ),
          Container(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) =>
                Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[500]!,
                  child: Container(
                    width: 80,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
            ),
          ),
          Container(height: 30),
          Shimmer.fromColors(
            baseColor: Colors.grey[700]!,
            highlightColor: Colors.grey[500]!,
            child: Container(
              width: 80,
              height: 16,
              color: Colors.white,
            ),
          ),
          Container(height: 30),
          Container(width: 300, height: 1, color: Colors.grey),
          Container(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) =>
            index == 1
                ? const Text(
              "/",
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            )
                : Shimmer.fromColors(
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[500]!,
              child: Container(
                width: 100,
                height: 16,
                color: Colors.white,
              ),
            ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 👇 Show shimmer only during first load
                    if (_isFirstLoad) _buildBannerShimmer() else
                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: banners_list.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final banner = banners_list[index];

                            return GestureDetector(
                              onTap: () {
                                final bannerId = banner.id.toString();
                                print("Clicked banner ID: $bannerId");
                                Get.to(ProductDetailsSccreen(productId: bannerId));

                              },
                              child: Image.network(
                                banner.imageMobilePath.toString(),
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            );
                          },
                        ),
                      ),
                      /* SizedBox(
                        height: 300,
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
                              banners_list[index].imageMobilePath.toString(),
                              fit: BoxFit.contain,
                              width: double.infinity,
                            );
                          },
                        ),
                      ),*/

                    // Indicators
                    if (_isFirstLoad) _buildIndicatorShimmer() else
                      Container(
                        height: 80,
                        margin: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            banners_list.length,
                                (index) => _buildIndicator(index == _currentPage),
                          ),
                        ),
                      ),

                    const SizedBox(height: 20),

                    if (_isFirstLoad) _buildTitleShimmer() else
                      const Text(
                        "NEW ARRIVALS",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    const SizedBox(height: 10),

                    // Horizontal ListView
                    if (_isFirstLoad) _buildCategoryListShimmer() else
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: category_list.length,
                          itemBuilder: (context, index) {
                            bool isSelected = selectedIndex == index;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                                getCategoryProducts(category_list[index].id.toString(),"4");
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      category_list[index].name.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: FontConstants.gothamPro,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      height: 2,
                                      width: isSelected ? 70 : 0,
                                      color: isSelected ? Colors.black : Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    // GridView
                    /*if (_isFirstLoad) _buildProductGridShimmer() else
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: category_product_list.length,
                          itemBuilder: (context, index) {
                            return HomeCategoryProductItem(
                              product: category_product_list[index],
                              onItemClick: () {
                                Get.to(() => ProductDetailsSccreen(productId: category_product_list[index].id.toString()));
                              },
                              onFavoriteClick: (newWishlistValue) async {
                                final skipValue = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST).toString();
                                if (skipValue == "1") {
                                  Get.to(() => const LoginScreen());
                                } else {
                                  addRemoveWishlist(category_product_list[index].id.toString());
                                }
                              },
                            );
                          },
                        ),
                      ),*/
                    _isFirstLoad
                        ? _buildProductGridShimmer()
                        : category_product_list.isEmpty
                        ? Container(
                      width: double.infinity,
                      height: 100,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: const Text(
                        'No products found',
                        style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                         ),
                      ),
                    )
                        : Padding(
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
                        itemCount: category_product_list.length,
                        itemBuilder: (context, index) {
                          return HomeCategoryProductItem(
                            product: category_product_list[index],
                            onItemClick: () {
                              Get.to(() => ProductDetailsSccreen(
                                productId: category_product_list[index].id.toString(),
                              ));
                            },
                            onFavoriteClick: (newWishlistValue) async {
                              final skipValue = PreferenceManager.getString(
                                  NetworkManager.PREF_IS_GUEST)
                                  .toString();
                              if (skipValue == "1") {
                                Get.to(() => const LoginScreen());
                              } else {
                                addRemoveWishlist(
                                    category_product_list[index].id.toString());
                              }
                            },
                          );
                        },
                      ),
                    ),


                    const SizedBox(height: 20),

                    if (_isFirstLoad) _buildTitleShimmer() else
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "EXPLORE MORE",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Image.asset(Drawables.arrow_farward
                            ,width: 70,
                            height: 40,
                          ),
                        ],
                      ),

                    Container(height: 40,),

                    //brands
                    if (_isFirstLoad) _buildBrandsGridShimmer() else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: partner_list.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => BranddetailsScreen(
                                  brand_name:partner_list[index].username.toString(),
                                  brand_Id:partner_list[index].id.toString(),
                                  image_brand:partner_list[index].imagePath.toString(),
                                ));
                              },
                              child: Image.network(
                                partner_list[index].imagePath.toString(),
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.image, color: Colors.grey),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),

                    Container(height: 20,),

                    if (_isFirstLoad) _buildTitleShimmer() else
                      const Text(
                        "YOU MAY ALSO LIKE",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),

                    Container(height: 40,),

                    if (_isFirstLoad) _buildHorizontalProductsShimmer() else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product_list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: SizedBox(
                                  width: 180,
                                  child: HomeProductItem(
                                    product: product_list[index],
                                    onItemClick: () {
                                      Get.to(() => ProductDetailsSccreen(productId: category_product_list[index].id.toString()));
                                    },
                                    onFavoriteClick: (newWishlistValue) async {
                                      final skipValue = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST).toString();
                                      if (skipValue == "1") {
                                        Get.to(() => const LoginScreen());
                                      } else {
                                        addRemoveWishlist(product_list[index].id.toString());
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                    Container(height: 40,),

                    if (_isFirstLoad) _buildTitleShimmer() else
                      const Text(
                        "GET THE LATEST TRENDS FIRST",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                    Container(height: 20,),

                    if (_isFirstLoad) _buildEmailFieldShimmer() else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: "ENTER YOUR EMAIL",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontConstants.gothamPro,
                              letterSpacing: 1.2,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontConstants.gothamPro,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),

                    Container(height: 30,),

                    if (_isFirstLoad) _buildFooterShimmer() else
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    print("INSTAGRAM clicked");
                                    print(PreferenceManager.getString(NetworkManager.PREF_INSTAGRAM).toString());
                                    _launchSocialLink(PreferenceManager.getString(NetworkManager.PREF_INSTAGRAM).toString());
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
                                    print(PreferenceManager.getString(NetworkManager.PREF_FACEBOOK).toString());
                                    _launchSocialLink(PreferenceManager.getString(NetworkManager.PREF_FACEBOOK).toString());
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
                                    _launchSocialLink(PreferenceManager.getString(NetworkManager.PREF_YOUTUBE).toString());
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
              ),
            ),
            // 👇 Only show circular progress for subsequent API calls, not first load
            /*if (isLoading && !_isFirstLoad)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),*/
          ]
      ),
    );
  }

  Future<void> _launchSocialLink(String url) async {
    Uri uri = Uri.parse(url);

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

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> getHome() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.home);
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
      final model = GetHomeModelResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          category_product_list.clear();
          category_product_list.addAll((model.data?.categoryProducts ?? []).take(4),);

          banners_list.clear();
          banners_list.addAll(model.data!.banners as Iterable<BannerHomee>);
          _startAutoSlide();

          category_list.clear();
          category_list.addAll(model.data!.categories as Iterable<CategoryHomee>);

          product_list.clear();
          product_list.addAll(model.data!.products as Iterable<ProductHomee>);

          partner_list.clear();
          partner_list.addAll((model.data?.partners ?? []).take(6),);

          // 👇 Set first load to false after successful data load
          _isFirstLoad = false;
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Home",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Home",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Home",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Home",
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

  Future<void> getCategoryProducts(String product_id,String take) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.home_cat_products);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final requestBody = {
      "category_id": product_id.toString(),
      "take": take.toString(),
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

      final model = GetCategoryHomeModelResponse.fromJson(json.decode(response.body));

      if (model.status == 1) {
        setState(() {
          category_product_list.clear();
          category_product_list.addAll((model.data?.categoryProducts ?? []).take(4),);
        });
      } else if (model.status == 0 || model.status == 401 || model.status != null) {
        Get.snackbar(
          "Products",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Products",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Products",
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
        getHome();
      }else if (model.status == 2) {
        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getHome();
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

  Future<void> guestSignup(String deviceToken) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.guest_api);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final requestBody = {
      "device_token": deviceToken.toString(),
    };
    final client = CustomHttpClient(http.Client());
    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      print('POST URL: $url');
      print('Request Body: ${jsonEncode(requestBody)}');
      print('Response Code: ${response.statusCode}');
      print("-------------------------------------FULL RESPONSE------------------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");
      final model = GuestResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          PreferenceManager.setString(NetworkManager.API_TOKEN, "Bearer ${model.data?.accessToken.toString()}");
          PreferenceManager.setString(NetworkManager.PREF_IS_GUEST, model.data!.user!.isGuest.toString());
          PreferenceManager.setString(NetworkManager.PREF_EMAIL, model.data!.user?.email ?? "");
          PreferenceManager.setString(NetworkManager.PREF_MOBILE, model.data!.user?.phoneNo ?? "");
          PreferenceManager.setString(NetworkManager.PREF_FULL_NAME, model.data!.user?.name ?? "");
          PreferenceManager.setString(NetworkManager.PREF_USER_ID, model.data!.user!.id.toString());
          PreferenceManager.setString(NetworkManager.PREF_CITY_NAME, model.data!.user?.city ?? "");
          PreferenceManager.setString(NetworkManager.PREF_DOB_NAME, model.data!.user?.dateOfBirth ?? "");
          PreferenceManager.setString(NetworkManager.PREF_ADRESS, model.data!.user?.address ?? "");
          PreferenceManager.setString(NetworkManager.PREF_POSTAL_CODE, model.data!.user?.postalCode ?? "");
          getHome();
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Guest",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Guest",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Guest",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Guest",
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
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

class Brand {
  final String imageUrl;

  Brand({
    required this.imageUrl,
  });
}


/*
import 'dart:async';
import 'dart:convert';
import 'package:drapyy/activities/BrandDetailsScreen.dart';
import 'package:drapyy/activities/LoginScreen.dart';
import 'package:drapyy/activities/PrivacyPolicyScreen.dart';
import 'package:drapyy/activities/TermsAndConditionScreen.dart';
import 'package:drapyy/activities/products_items/HomeCategoryProductItem.dart';
import 'package:drapyy/activities/ProductDetailsSccreen.dart';
import 'package:drapyy/activities/products_items/HomeProductItem.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:drapyy/models/Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../activities/products_items/ProductItemAlt.dart';
import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../network/Network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  bool isLoading = false;

  List<CategoryProductHomee> category_product_list = [];
  List<BannerHomee> banners_list = [];
  List<CategoryHomee> category_list = [];
  List<PartnerHomee> partner_list = [];
  List<ProductHomee> product_list = [];
  int? selectedIndex; // 👈 null means no item selected yet

  */
/*@override
  void initState() {
    super.initState();
    _startAutoSlide();
    getHome();
  }*/
/*


  @override
  void initState() {
    super.initState();
    checkGuestStatus();
  }

  Future<void> checkGuestStatus() async {
    print("HOME_checkGuestStatus------------>");
    String isGuest = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST)?.toString() ?? "";
    if (isGuest.isNotEmpty) {
      print("HOME_checkGuestStatus------------1>-------isGuest--->"+isGuest.toString());
      if (isGuest == "0") {
        print("HOME_checkGuestStatus------------2>");
        getHome();
      } else {
        print("HOME_checkGuestStatus------------3>");
        guestSignup("sdhfjdshfjhsd j fhdsjgf hsgdhfgshdghf gdshgf hsdg fsd");
      }
    } else {
      print("HOME_checkGuestStatus------------4>");
      guestSignup("sdhfjdshfjhsd j fhdsjgf hsgdhfgshdghf gdshgf hsdg fsd");
    }
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

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: 2, // vertical line
      height: isActive ? 70 : 40, // taller if selected
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Banner Slider
                  SizedBox(
                    height: 300,
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
                          banners_list[index].imageMobilePath.toString(),
                          fit: BoxFit.contain,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),

                  // Indicators
                  Container(
                    height: 80,
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        banners_list.length,
                            (index) => _buildIndicator(index == _currentPage),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "NEW ARRIVALS",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Horizontal ListView
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: category_list.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIndex == index;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            getCategoryProducts(category_list[index].id.toString(),"4");
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  category_list[index].name.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: FontConstants.gothamPro,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // 👇 Underline shown only if selected
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: 2,
                                  width: isSelected ? 70 : 0,
                                  color: isSelected ? Colors.black : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // GridView - Fixed height based on content
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: category_product_list.length,
                      itemBuilder: (context, index) {
                        return HomeCategoryProductItem(
                          product: category_product_list[index],
                          onItemClick: () {
                            Get.to(() => ProductDetailsSccreen(productId: category_product_list[index].id.toString()));
                          },
                          onFavoriteClick: (newWishlistValue) async {
                            final skipValue = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST).toString();
                            if (skipValue == "1") {
                              Get.to(() => const LoginScreen());
                            } else {
                              addRemoveWishlist(category_product_list[index].id.toString());
                            }
                          },
                        );
                      },
                    ),
                  ),

                  // Add some bottom padding
                  const SizedBox(height: 20),

                  Row(
                    mainAxisSize: MainAxisSize.min, // 👈 keeps children tight
                    children: [
                      Text(
                        "EXPLORE MORE",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Image.asset(Drawables.arrow_farward
                        ,width: 70,
                        height: 40,
                      ),
                    ],
                  ),

                  Container(height: 40,),

                  //brands
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5, // width / height → tweak until rows look right
                        crossAxisSpacing: 15.0,  // horizontal space
                        mainAxisSpacing: 10.0,   // vertical space
                      ),
                      itemCount: partner_list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                              Get.to(() => BranddetailsScreen(
                              brand_name:partner_list[index].username.toString(),
                              brand_Id:partner_list[index].id.toString(),
                              image_brand:partner_list[index].imagePath.toString(),
                             ));
                          },
                          child: Image.network(
                            partner_list[index].imagePath.toString(),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.image, color: Colors.grey),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  Container(height: 20,),

                  const Text(
                    "YOU MAY ALSO LIKE",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),

                  Container(height: 40,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 250, // 👈 adjust based on ProductItemAlt height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal, // 👈 horizontal scroll
                        itemCount: product_list.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0), // space between items
                            child: SizedBox(
                              width: 180, // 👈 each item width (tweak as needed)
                              child: HomeProductItem(
                                product: product_list[index],
                                onItemClick: () {
                                  Get.to(() => ProductDetailsSccreen(productId: category_product_list[index].id.toString()));
                                },
                                onFavoriteClick: (newWishlistValue) async {
                                  final skipValue = PreferenceManager.getString(NetworkManager.PREF_IS_GUEST).toString();
                                  if (skipValue == "1") {
                                    Get.to(() => const LoginScreen());
                                  } else {
                                    addRemoveWishlist(product_list[index].id.toString());
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),



                  Container(height: 40,),

                  const Text(
                    "GET THE LATEST TRENDS FIRST",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  Container(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center, // 👈 Center text & hint
                      decoration: const InputDecoration(
                        hintText: "ENTER YOUR EMAIL",
                        hintStyle: TextStyle(
                          color: Colors.grey,       // 👈 hint color
                          fontSize: 14,             // 👈 hint size
                          fontWeight: FontWeight.w400,
                          fontFamily: FontConstants.gothamPro,
                          letterSpacing: 1.2,       // 👈 spacing for uppercase look
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,       // 👈 text color
                        fontSize: 16,              // 👈 entered text size
                        fontWeight: FontWeight.w400,
                        fontFamily: FontConstants.gothamPro,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),


                  Container(height: 30,),
                  Container(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 40),
                        Image.asset(
                          Drawables.img_drappy_white,
                          width: 200,
                          height: 100,
                        ),

                        Container(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                print("INSTAGRAM clicked");
                                print(PreferenceManager.getString(NetworkManager.PREF_INSTAGRAM).toString());
                                _launchSocialLink(PreferenceManager.getString(NetworkManager.PREF_INSTAGRAM).toString());
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
                                print(PreferenceManager.getString(NetworkManager.PREF_FACEBOOK).toString());
                                _launchSocialLink(PreferenceManager.getString(NetworkManager.PREF_FACEBOOK).toString());

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
                                print("PINTEREST clicked");
                              },
                              child: Text(
                                "PINTEREST",
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

                        Container(height: 30),
                        InkWell(
                          onTap: () {
                            print("YOUTUBE clicked");

                            _launchSocialLink(PreferenceManager.getString(NetworkManager.PREF_YOUTUBE).toString());
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

                        Container(height: 30),
                        Container(width: 300, height: 1, color: Colors.grey),
                        Container(height: 30),

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
            ),
          ),
          if (isLoading)
            Container(
              child: const Center(
                child: CircularProgressIndicator(), // ✅ Centered progress bar
              )
            ),
        ]
      ),
    );
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



  Future<void> getHome() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.home);
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
      final model = GetHomeModelResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {

          category_product_list.clear();
          category_product_list.addAll((model.data?.categoryProducts ?? []).take(4),);

          banners_list.clear();
          banners_list.addAll(model.data!.banners as Iterable<BannerHomee>);
          _startAutoSlide();

          category_list.clear();
          category_list.addAll(model.data!.categories as Iterable<CategoryHomee>);

          product_list.clear();
          product_list.addAll(model.data!.products as Iterable<ProductHomee>);

          partner_list.clear();
          partner_list.addAll((model.data?.partners ?? []).take(6),);

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

  Future<void> getCategoryProducts(String product_id,String take) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.home_cat_products);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };


    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "category_id": product_id.toString(),
      "take": take.toString(),
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
      GetCategoryHomeModelResponse.fromJson(json.decode(response.body));

      if (model.status == 1) {

        setState(() {
          */
/*category_product_list.clear();
          category_product_list.addAll(model.data!.categoryProducts as Iterable<CategoryProductHomee>);*/
/*

          category_product_list.clear();
          category_product_list.addAll((model.data?.categoryProducts ?? []).take(4),);
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
        getHome();
      }else if (model.status == 2) {
        Get.snackbar(
          "Wishlist",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        getHome();
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




  Future<void> guestSignup(String deviceToken) async {
    setState(() {
      isLoading = true;
    });
    final url =
    Uri.parse(NetworkManager.BASE_URL + NetworkManager.guest_api);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final requestBody = {
      "device_token": deviceToken.toString(),
    };
    final client = CustomHttpClient(http.Client());
    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      print('POST URL: $url');
      print('Request Body: ${jsonEncode(requestBody)}');
      print('Response Code: ${response.statusCode}');
      print("-------------------------------------FULL RESPONSE------------------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");
      final model = GuestResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {

          PreferenceManager.setString(NetworkManager.API_TOKEN, "Bearer ${model.data?.accessToken.toString()}");
          PreferenceManager.setString(NetworkManager.PREF_IS_GUEST, model.data!.user!.isGuest.toString());
          PreferenceManager.setString(NetworkManager.PREF_EMAIL, model.data!.user?.email ?? "");
          PreferenceManager.setString(NetworkManager.PREF_MOBILE, model.data!.user?.phoneNo ?? "");
          PreferenceManager.setString(NetworkManager.PREF_FULL_NAME, model.data!.user?.name ?? "");
          PreferenceManager.setString(NetworkManager.PREF_USER_ID, model.data!.user!.id.toString());
          PreferenceManager.setString(NetworkManager.PREF_CITY_NAME, model.data!.user?.city ?? "");
          PreferenceManager.setString(NetworkManager.PREF_DOB_NAME, model.data!.user?.dateOfBirth ?? "");
          PreferenceManager.setString(NetworkManager.PREF_ADRESS, model.data!.user?.address ?? "");
          PreferenceManager.setString(NetworkManager.PREF_POSTAL_CODE, model.data!.user?.postalCode ?? "");
          getHome();

          Get.snackbar(
            "Guest",
            model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: EdgeInsets.all(10),
            duration: Duration(seconds: 2),
          );
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Status "+model.status.toString(),
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Status "+model.status.toString(),
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Status "+model.status.toString(),
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
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
class Brand {
  final String imageUrl;

  Brand({
    required this.imageUrl,
  });
}
*/
