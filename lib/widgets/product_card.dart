import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onAddTap;

  const ProductCard({
    super.key,
    this.product,
    this.onFavoriteTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/product-details', arguments: product),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.grey.shade100,
                    child: const Center(child: Icon(Icons.image, color: Colors.grey, size: 40)),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.favorite_outline, size: 20, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?.name ?? "Fresh Product",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product?.category ?? "Organic",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product?.price ?? '0.00'}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6FAE3D),
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Color(0xFF6FAE3D)),
                        onPressed: onAddTap,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
