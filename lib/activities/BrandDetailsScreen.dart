



import 'package:drapyy/activities/FilterScreen.dart';
import 'package:drapyy/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/FontsConstants.dart';
import 'NotificationsScreen.dart';
import 'ProductItemAlt.dart';

class BranddetailsScreen extends StatefulWidget {
  const BranddetailsScreen({Key? key}) : super(key: key);

  @override
  State<BranddetailsScreen> createState() => _BranddetailsScreenState();
}

class _BranddetailsScreenState extends State<BranddetailsScreen> {
  // State variables
  int _selectedTabIndex = 0;
  final List<String> _navigationTabs = ['Men', 'Women', 'Kids', 'Beauty'];
  final List<Product> _products = [];
  bool _isFollowing = false;
  int _followerCount = 12;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    // Simulating product loading
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

    setState(() {
      _products.clear();
      _products.addAll(products);
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    // You can add logic here to filter products based on selected tab
    _filterProductsByCategory(_navigationTabs[index]);
  }

  void _filterProductsByCategory(String category) {
    // Implement your filtering logic here
    print('Filtering products for category: $category');
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
      if (_isFollowing) {
        _followerCount++;
      } else {
        _followerCount--;
      }
    });
  }

  void _onProductTap(Product product) {
    // Handle product tap
    print('Product tapped: ${product.name}');
    // You can navigate to product detail screen here
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
            // Header Section
            //_buildHeaderSection(),
            Row(
              children: [

                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,),
                  onPressed: () {
                    // Get.to(() => NotificationsScreen());
                  },
                ),
                // Expanded makes the Text take remaining space and stay centered
                Expanded(
                  child: Center(
                    child: Text(
                      "Brand Name", // 👈 your text here
                      style: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // same width as IconButton

                // Back button


                // To balance Row (so title stays centered even with only one button)
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
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black12,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 50,
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
                              "APPIDEX SPORTS",
                              style: TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 14,
                                fontWeight:FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                        ),
                        Text(
                            "2332",
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
                      Get.to(() => FilterScreen());
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


  Widget _buildNavigationTabs() {
    return SizedBox(
        height: 40,
        child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _navigationTabs.length,
        itemBuilder: (context, index) {
        final isSelected = index == selectedIndex;

      return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _navigationTabs[index],
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

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.7,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return ProductItemAlt(
          product: _products[index],
          onItemClick: () {
            print('Product clicked: ${_products[index].name}');
          },
          onFavoriteClick: () {
            setState(() {
              //products[index].isFavorite = !products[index].isFavorite;
            });
            print('Favorite toggled for: ${_products[index].name}');
          },
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'FILTERS',
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Filter options will be implemented here',
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'CLOSE',
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'SORT BY',
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSortOption('Price: Low to High'),
            _buildSortOption('Price: High to Low'),
            _buildSortOption('Newest First'),
            _buildSortOption('Popularity'),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: FontConstants.gothamPro,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        // Implement sort logic here
        print('Sort by: $title');
      },
    );
  }
}