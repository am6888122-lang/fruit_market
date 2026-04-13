import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';
import 'package:fruit_market/features/favorites/presentation/controllers/favorite_controller.dart';
import 'package:fruit_market/features/cart/presentation/controllers/cart_controller.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.put(FavoriteController());
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: const CustomAppBar(title: "My Favorites", showBackButton: false),
      body: Obx(() {
        if (favoriteController.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 100,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  "No favorites yet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Start adding products to your favorites",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: favoriteController.favorites.length,
            itemBuilder: (context, index) {
              final product = favoriteController.favorites[index];
              return _buildFavoriteCard(
                product: product,
                onFavoriteTap: () => favoriteController.removeFavorite(product.id),
                onAddToCart: () {
                  cartController.addToCart(product);
                  Get.snackbar(
                    "Added to Cart",
                    "${product.name} has been added to your cart",
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildFavoriteCard({
    required product,
    required VoidCallback onFavoriteTap,
    required VoidCallback onAddToCart,
  }) {
    return GestureDetector(
      onTap: () => Get.toNamed('/product-details', arguments: product),
      child: Container(
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
                    child: product.image.isNotEmpty
                        ? Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.image, color: Colors.grey, size: 40),
                              );
                            },
                          )
                        : const Center(
                            child: Icon(Icons.image, color: Colors.grey, size: 40),
                          ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        size: 20,
                        color: Colors.red,
                      ),
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
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6FAE3D),
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: onAddToCart,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6FAE3D),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
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
