import 'package:get/get.dart';
import 'package:fruit_market/models/product_model.dart';

class FavoriteController extends GetxController {
  var favorites = <Product>[].obs;

  void toggleFavorite(Product product) {
    if (isFavorite(product.id)) {
      favorites.removeWhere((p) => p.id == product.id);
      Get.snackbar(
        "Removed from Favorites",
        "${product.name} has been removed from your favorites",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      favorites.add(product);
      Get.snackbar(
        "Added to Favorites",
        "${product.name} has been added to your favorites",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void removeFavorite(String productId) {
    var product = favorites.firstWhereOrNull((p) => p.id == productId);
    if (product != null) {
      favorites.removeWhere((p) => p.id == productId);
      Get.snackbar(
        "Removed",
        "${product.name} removed from favorites",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool isFavorite(String productId) {
    return favorites.any((p) => p.id == productId);
  }
}
