import 'dart:async';
import 'dart:convert';
import 'package:drapyy/activities/BrandDetailsScreen.dart';
import 'package:drapyy/activities/ProductDetailsSccreen.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:drapyy/models/Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../activities/ProductItemAlt.dart';
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



  // Static list of banner images (replace with API data later)
  final List<String> _banners = [
    "https://picsum.photos/id/1011/800/400",
    "https://picsum.photos/id/1012/800/400",
    "https://picsum.photos/id/1013/800/400",
    "https://picsum.photos/id/1014/800/400",
  ];

  // Static list of strings
  final List<String> items = [
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
  ];


  final List<Product> products = [
    Product(
      name: 'CLAUDETTE CORSET hsdhjsdh djshdjhs',
      description: 'SHIRT DRESS WHITE shdjhdsjhds s',
      code: '77147',
      imageUrl: 'https://picsum.photos/id/1011/800/400', // Replace with your image path
    ),
    Product(
      name: 'CLAUDETTE CORSET',
      description: 'SHIRT DRESS WHITE',
      code: '77147',
      imageUrl: 'https://picsum.photos/id/1011/800/400', // Replace with your image path
    ),

    Product(
      name: 'CLAUDETTE CORSET2',
      description: 'SHIRT DRESS WHITE2',
      code: '771472',
      imageUrl: 'https://picsum.photos/id/1011/800/400', // Replace with your image path
    ),
    // Add more products as needed
  ];

  final List<Product> products2 = [
    Product(
      name: 'CLAUDETTE CORSET hsdhjsdh djshdjhs',
      description: 'SHIRT DRESS WHITE shdjhdsjhds s',
      code: '77147',
      imageUrl: 'https://picsum.photos/id/1012/800/400', // Replace with your image path
    ),
    Product(
      name: 'CLAUDETTE CORSET',
      description: 'SHIRT DRESS WHITE',
      code: '77147',
      imageUrl: 'https://picsum.photos/id/1012/800/400', // Replace with your image path
    ),

    Product(
      name: 'CLAUDETTE CORSET2',
      description: 'SHIRT DRESS WHITE2',
      code: '771472',
      imageUrl: 'hhttps://picsum.photos/id/1012/800/400', // Replace with your image path
    ),

    Product(
      name: 'CLAUDETTE CORSET2',
      description: 'SHIRT DRESS WHITE2',
      code: '771472',
      imageUrl: 'https://picsum.photos/id/1012/800/400', // Replace with your image path
    ),
    // Add more products as needed
  ];

  final List<Brand> brands = [
    Brand(
      imageUrl: 'https://picsum.photos/id/1012/800/400', // Replace with your image path
    ),
    Brand(
      imageUrl: 'https://picsum.photos/id/1012/800/400', // Replace with your image path
    ),
    Brand(
      imageUrl: 'https://picsum.photos/id/1012/800/400', // Replace with your image path
    ),
    Brand(
      imageUrl: 'https://picsum.photos/id/1012/800/400', // Replace with your image path
    ),
    Brand(
      imageUrl: 'https://picsum.photos/id/1011/800/400', // Replace with your image path
    ),
    Brand(
      imageUrl: 'https://picsum.photos/id/1011/800/400', // Replace with your image path
    ),
    // Add more products as needed
  ];




  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    getHome();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Banner Slider
              SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _banners.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.network(
                      _banners[index],
                      fit: BoxFit.cover,
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
                    _banners.length,
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
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${items[index]} clicked")),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        alignment: Alignment.center,
                        child: Text(
                          items[index],
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
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductItemAlt(
                      product: products[index],
                      onItemClick: () {
                        // Handle complete item click
                        //print('Product clicked: ${products[index].name}');
                        Get.to(() => const ProductDetailsSccreen());

                        // Add your navigation logic here
                      },
                      onFavoriteClick: () {
                        // Handle favorite click
                        setState(() {
                          //products[index].isFavorite = !products[index].isFavorite;
                        });
                        print('Favorite toggled for: ${products[index].name}');
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
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // 👉 Handle click here
                        debugPrint("Clicked brand: ${brands[index].imageUrl}");
                        Get.to(() => const BranddetailsScreen());

                      },
                      child: Image.network(
                        brands[index].imageUrl.toString(),
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
                    itemCount: products2.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0), // space between items
                        child: SizedBox(
                          width: 180, // 👈 each item width (tweak as needed)
                          child: ProductItemAlt(
                            product: products2[index],
                            onItemClick: () {
                              print('Product clicked: ${products2[index].name}');
                              // Add your navigation logic here
                            },
                            onFavoriteClick: () {
                              setState(() {
                                // products[index].isFavorite = !products[index].isFavorite;
                              });
                              print('Favorite toggled for: ${products2[index].name}');
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
    );
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
          Get.snackbar(
            "Status ${model.status}",
            model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2),
          );
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

}
class Brand {
  final String imageUrl;

  Brand({
    required this.imageUrl,
  });
}
