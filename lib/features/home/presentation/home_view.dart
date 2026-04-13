import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/utils/size_config.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';
import 'package:fruit_market/features/home/presentation/controllers/fruit_controller.dart';
import 'package:fruit_market/features/cart/presentation/controllers/cart_controller.dart';
import 'package:fruit_market/features/favorites/presentation/controllers/favorite_controller.dart';
import 'package:fruit_market/models/product_api_model.dart';
import 'package:fruit_market/models/product_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final FruitController controller = Get.put(FruitController());
    final CartController cartController = Get.put(CartController());
    final FavoriteController favoriteController = Get.put(FavoriteController());

    return Scaffold(
      appBar: CustomAppBar(
        title: "Fruit Market",
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () => Get.toNamed('/notifications'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTopSearch(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6FAE3D)),
                  ),
                );
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 40, color: Colors.red),
                      const SizedBox(height: 16),
                      Text("Error: ${controller.errorMessage}", style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => controller.fetchFruits(),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6FAE3D)),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchFruits(),
                color: const Color(0xFF6FAE3D),
                child: GridView.builder(
                  padding: EdgeInsets.all(getProportionateScreenWidth(16)),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: getProportionateScreenWidth(16),
                    mainAxisSpacing: getProportionateScreenHeight(16),
                  ),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return HomeProductCard(
                      product: product,
                      cartController: cartController,
                      favoriteController: favoriteController,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSearch() {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(16)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: "Search groceries",
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class HomeProductCard extends StatelessWidget {
  final ProductApiModel product;
  final CartController cartController;
  final FavoriteController favoriteController;

  const HomeProductCard({
    super.key,
    required this.product,
    required this.cartController,
    required this.favoriteController,
  });

  Product _convertToProduct() {
    return Product(
      id: product.id.toString(),
      name: product.title,
      category: product.category,
      description: product.description,
      price: product.price,
      image: product.thumbnail,
      nutrition: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    final convertedProduct = _convertToProduct();
    
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
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey.shade50,
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.image_not_supported, color: Colors.grey));
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Obx(() {
                      final isFavorite = favoriteController.isFavorite(convertedProduct.id);
                      return GestureDetector(
                        onTap: () => favoriteController.toggleFavorite(convertedProduct),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_outline,
                            size: 20,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6FAE3D),
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Color(0xFF6FAE3D), size: 28),
                        onPressed: () => cartController.addToCart(convertedProduct),
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
