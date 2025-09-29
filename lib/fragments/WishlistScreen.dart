import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../activities/ProductItemAlt.dart';
import '../helper/FontsConstants.dart';
import '../helper/colors.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {


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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
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
    );
  }
}

/*


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
        height: 200,
        */
/*decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),*//*

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with fixed height
            Container(
              height: 165,
              width: double.infinity,
              child: Stack(
                children: [
                  // Product Image
                  ClipRRect(
                    */
/*borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),*//*

                    child: SizedBox(
                      height: 165,
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
                    right: 15.0,
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
                          color: grey_color,
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
                      color: grey_color,
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
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(width: 5),
                    Text(
                      "PKR " + "333333",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
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
*/
