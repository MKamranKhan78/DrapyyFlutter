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
      name: 'CLAUDETTE CORSET',
      description: 'SHIRT DRESS WHITE',
      code: '77147',
      imageUrl: 'assets/images/product1.jpg', // Replace with your image path
    ),
    Product(
      name: 'CLAUDETTE CORSET',
      description: 'SHIRT DRESS WHITE',
      code: '77147',
      imageUrl: 'assets/images/product2.jpg', // Replace with your image path
    ),

    Product(
      name: 'CLAUDETTE CORSET2',
      description: 'SHIRT DRESS WHITE2',
      code: '771472',
      imageUrl: 'assets/images/product2.jpg', // Replace with your image path
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
        child: SingleChildScrollView( // 👈 Wrap with SingleChildScrollView
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

              // Horizontal ListView - Need to constrain height
              SizedBox( // 👈 Constrain height for horizontal ListView
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

              // GridView - Need to constrain height or use shrinkWrap
              SizedBox( // 👈 Constrain height for GridView
                height: 400, // Adjust this height based on your content
                child: GridView.builder(
                  //physics: const NeverScrollableScrollPhysics(), // 👈 Disable inner scrolling
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductItemAlt(product: products[index]);
                  },
                ),
              ),

              // Add some bottom padding to avoid overflow
              const SizedBox(height: 20),
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




// Alternative version with white background text (if you prefer no overlay)
class ProductItemAlt extends StatefulWidget {
  final Product product;

  const ProductItemAlt({super.key, required this.product});

  @override
  State<ProductItemAlt> createState() => _ProductItemAltState();
}

class _ProductItemAltState extends State<ProductItemAlt> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: 200, // 👈 Fixed height for image
            width: double.infinity, // 👈 Match parent width
            child: Stack(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: SizedBox( // 👈 Add SizedBox with fixed height
                    height: 200, // 👈 Fixed height
                    width: double.infinity, // 👈 Match parent width
                    child: Image.asset(
                      widget.product.imageUrl,
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

                // Favorite Button - positioned in top right
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 18.0,
                        color: isFavorite ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.product.description,
                  style: const TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.product.code,
                  style: const TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
