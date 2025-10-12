import 'package:flutter/material.dart';
import '../../helper/FontsConstants.dart';
import '../../helper/colors.dart'; // adjust path based on your project

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
      onTap: onItemClick,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with fixed height
            Container(
              height: 165,
              width: double.infinity,
              color: Colors.grey.shade100,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image, color: Colors.grey),
                        );
                      },
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoriteClick,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: grey_color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: grey_color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "PKR ${product.code}",
                            style: const TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "PKR 333333",
                            style: const TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 1.5,
                            ),
                          ),
                        ],
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