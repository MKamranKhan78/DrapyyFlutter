import 'package:flutter/material.dart';
import '../../helper/FontsConstants.dart';
import '../../helper/colors.dart';
import '../../models/Model.dart'; // adjust path based on your project

class SearchProductItemAlt extends StatelessWidget {
  final CategoryProductHomee product;
  final void Function(int newWishlistValue) onFavoriteClick; // 👈 changed
  final VoidCallback onItemClick;

  const SearchProductItemAlt({
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
            // Image
            Container(
              height: 165,
              width: double.infinity,
              color: Colors.grey.shade100,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      product.imageUrl.toString(),
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
                      onTap: () {
                        // 👇 toggle value: if 0 → 1, else 0
                        final newValue = (product.isWishlist == 0) ? 1 : 0;
                        onFavoriteClick(newValue);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          product.isWishlist == 0
                              ? Icons.favorite_border
                              : Icons.favorite,
                          size: 20,
                          color: product.isWishlist == 0
                              ? Colors.black
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Info
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name.toString(),
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
                      product.brandName.toString(),
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
                          // ✅ If offerPrice exists — show discounted and struck-out price
                          if (product.variant?.offerPrice != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "PKR ${product.variant?.offerPrice}",
                                  style: const TextStyle(
                                    fontFamily: FontConstants.gothamPro,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "PKR ${product.variant?.price}",
                                  style: const TextStyle(
                                    fontFamily: FontConstants.gothamPro,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 1.5,
                                  ),
                                ),
                              ],
                            )
                          else
                          // ✅ Show only the actual price when no offer
                            Text(
                              "PKR ${product.variant?.price ?? ''}",
                              style: const TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
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