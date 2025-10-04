import 'package:drapyy/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/FontsConstants.dart';
import '../helper/drawables.dart';
import 'ProductItemAlt.dart';

class ProductDetailsSccreen extends StatefulWidget {
  const ProductDetailsSccreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsSccreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailsSccreen> {
  String? _selectedSize;
  String? _selectedColor;

  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<Color> colors = [
    const Color(0xFF964B00),
    const Color(0xFFFF0000),
    const Color(0xFF0000FF),
    const Color(0xFF008000),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Section
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 400,
                    color: const Color(0xFFF5F5F5),
                    child: Image.network(
                      "https://picsum.photos/id/1011/800/400",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image, color: Colors.grey),
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
                        icon: const Icon(Icons.arrow_back, size: 20),
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
                      padding: const EdgeInsets.only(left: 15.0,top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'HOODIE',
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: grey,
                            ),
                          ),
                          Text(
                            '\$120.00',
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
                            children: sizes.asMap().entries.map((entry) {
                              final index = entry.key;
                              final size = entry.value;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedSize = size;
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: _selectedSize == size
                                        ? Colors.black
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      size,
                                      style: TextStyle(
                                        fontFamily: FontConstants.gothamPro,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: _selectedSize == size
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Container(width: 20,),



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
                          Container(width: 10,),
                          Row(
                            children: colors.asMap().entries.map((entry) {
                              final index = entry.key;
                              final color = entry.value;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = index.toString();
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                    border: _selectedColor == index.toString()
                                        ? Border.all(color: Colors.black, width: 2)
                                        : null,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),


                        ],
                      ),
                    ),



                    const SizedBox(height: 30),

                    // Add to Cart Button
                    Container(
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


                    // Description Section
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 25),
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
                      padding: const EdgeInsets.only(left: 15.0,top: 10,right: 15),
                      child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
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
                      padding: const EdgeInsets.only(left: 15.0,top: 25),
                      child:
                      Text(
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
                      padding: const EdgeInsets.only(left: 15.0,top: 10,right: 15),
                      child:
                      Text(
                      'High-quality waistcoat with contrasting details. Perfect for formal occasions and business events.',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchingItem(String title) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}