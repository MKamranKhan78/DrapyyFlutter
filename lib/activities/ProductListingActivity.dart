

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';
import '../helper/colors.dart';
import 'products_items/ProductItemAlt.dart';

class ProductListingActivity extends StatefulWidget {
  const ProductListingActivity({super.key});

  @override
  State<ProductListingActivity> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListingActivity> {


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // 👈 This handles status bar spacing
        child: Column(
          children: [
            Container(height: 10,),
            // Title
            Text(
              "PRODUCTS",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: FontConstants.gothamPro,
              ),
            ),
            Container(height: 20,),

            // Vertical List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GridView.builder(
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
                        print('Product clicked: ${products[index].name}');
                      },
                      onFavoriteClick: () {
                        setState(() {
                          //products[index].isFavorite = !products[index].isFavorite;
                        });
                        print('Favorite toggled for: ${products[index].name}');
                      },
                    );
                  },
                ),
              ),
            ),
            Container(height: 20,),

          ],
        ),
      ),
    );
  }

}


