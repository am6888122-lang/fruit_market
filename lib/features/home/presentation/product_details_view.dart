import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/features/cart/presentation/controllers/cart_controller.dart';
import 'package:fruit_market/features/favorites/presentation/controllers/favorite_controller.dart';
import 'package:fruit_market/models/product_api_model.dart';
import 'package:fruit_market/models/product_model.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductApiModel? productApi = Get.arguments as ProductApiModel?;
    final CartController cartController = Get.put(CartController());
    final FavoriteController favoriteController = Get.put(FavoriteController());

    if (productApi == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Product Details")),
        body: const Center(child: Text("No product data")),
      );
    }

    final product = Product(
      id: productApi.id.toString(),
      name: productApi.title,
      category: productApi.category,
      description: productApi.description,
      price: productApi.price,
      image: productApi.thumbnail,
      nutrition: [],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            final isFavorite = favoriteController.isFavorite(product.id);
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: isFavorite ? Colors.red : Colors.black87,
              ),
              onPressed: () => favoriteController.toggleFavorite(product),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          productApi.thumbnail,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image, size: 100, color: Colors.grey);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    productApi.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        productApi.category,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        productApi.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    productApi.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Product Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow("Category", productApi.category),
                  _buildInfoRow("Stock", "${productApi.stock} available"),
                  _buildInfoRow("Rating", "${productApi.rating}/5"),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildBottomSection(product, cartController),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF6FAE3D),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBottomSection(Product product, CartController cartController) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Price", style: TextStyle(color: Colors.grey)),
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6FAE3D),
                ),
              ),
            ],
          ),
          const SizedBox(width: 32),
          Expanded(
            child: CustomButton(
              text: "ADD TO CART",
              onPressed: () {
                cartController.addToCart(product);
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
