import 'dart:async';
import 'package:drapyy/helper/colors.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

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




  @override
  void initState() {
    super.initState();
    _startAutoSlide();
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
      width: 4, // vertical line
      height: isActive ? 70 : 40, // taller if selected
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // 👈 keeps banner below status bar
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

            Container(height: 20,),

            Text(
              "New Arrivals",
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),

        Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10),
          child: SizedBox(
            height: 80, // height of the horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // 👈 horizontal
              itemCount: items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // 👇 Click event for each item
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
                        color: Colors.black, // ✅ change text to white
                        fontSize: 14,
                        fontFamily: FontConstants.gothamPro,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),



             Container(
               height: 200,
               child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.7, // Adjust based on your design
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductItem(product: products[index]);
                  },
                ),
             ),




        ],
        ),
      ),
    );
  }*/

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
                "New Arrivals",
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

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
                        print('Product clicked: ${products[index].name}');
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
                children: [
                  Text(
                    "Explore More",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),

                  Icon(
                    Icons.arrow_right_alt,
                    size: 100,
                    color: app_color_black,
                  ),
                ],
              )





            ],
          ),
        ),
      ),
    );
  }

}

class Product {
  final String name;
  final String description;
  final String code;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.code,
    required this.imageUrl,
  });
}





class ProductItemAlt extends StatelessWidget {
  final Product product;
  final VoidCallback onItemClick;
  final VoidCallback onFavoriteClick;

  const ProductItemAlt({
    super.key,
    required this.product,
    required this.onItemClick,
    required this.onFavoriteClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemClick, // Complete item click
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with fixed height
            Container(
              height: 170,
              width: double.infinity,
              child: Stack(
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Image.network(
                        product.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.image, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  ),

                  // Favorite Button - with separate click handler
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: GestureDetector(
                      onTap: onFavoriteClick,
                      child: Container(
                        padding: const EdgeInsets.all(6.0), // 👈 Increased padding for larger size
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0), // 👈 Added rounded corners
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          size: 22.0, // 👈 Increased icon size
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0,top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                     maxLines: 2, // ✅ Limits to 2 lines
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0,top: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "PKR " + product.code,
                      style: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(width: 5),
                    Text(
                      "PKR " + "333333",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.black,
                        decorationThickness: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
