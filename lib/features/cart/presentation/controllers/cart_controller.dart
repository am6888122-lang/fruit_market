import 'package:get/get.dart';
import 'package:fruit_market/models/product_model.dart';

class CartItem {
  final Product product;
  final double oldPrice;
  final double savedAmount;
  var quantity = 1.obs;

  CartItem({
    required this.product, 
    required this.oldPrice,
    required this.savedAmount,
    int qty = 1
  }) {
    quantity.value = qty;
  }
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  
  var vegetableItems = <CartItem>[].obs;
  var dryFruitItems = <CartItem>[].obs;
  var fruitsItems = <CartItem>[].obs;

  void _groupItems() {
    vegetableItems.assignAll(
      cartItems.where((item) => item.product.category == "Vegetables")
    );
    dryFruitItems.assignAll(
      cartItems.where((item) => item.product.category == "Dry Fruits")
    );
    fruitsItems.assignAll(
      cartItems.where((item) => item.product.category == "Fruits")
    );
  }

  void addToCart(Product product) {
    var existingItem = cartItems.firstWhereOrNull(
      (item) => item.product.id == product.id
    );
    
    if (existingItem != null) {
      existingItem.quantity.value++;
      Get.snackbar(
        "Updated",
        "${product.name} quantity increased",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      cartItems.add(CartItem(
        product: product,
        oldPrice: product.price + 10,
        savedAmount: 10,
      ));
      Get.snackbar(
        "Added to Cart",
        "${product.name} has been added to your cart",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
    _groupItems();
  }

  void removeFromCart(String productId) {
    var item = cartItems.firstWhereOrNull((item) => item.product.id == productId);
    if (item != null) {
      cartItems.removeWhere((item) => item.product.id == productId);
      Get.snackbar(
        "Removed",
        "${item.product.name} removed from cart",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      _groupItems();
    }
  }

  void incrementQuantity(String productId) {
    var item = cartItems.firstWhereOrNull((item) => item.product.id == productId);
    if (item != null) {
      item.quantity.value++;
      _groupItems();
    }
  }

  void decreaseQuantity(String productId) {
    var item = cartItems.firstWhereOrNull((item) => item.product.id == productId);
    if (item != null && item.quantity.value > 1) {
      item.quantity.value--;
    } else if (item != null && item.quantity.value == 1) {
      removeFromCart(productId);
    }
    _groupItems();
  }

  void clearCart() {
    cartItems.clear();
    _groupItems();
    Get.snackbar(
      "Cart Cleared",
      "All items have been removed from your cart",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  double get subTotal {
    double total = 0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity.value;
    }
    return total;
  }

  double get totalSavings {
    double saved = 0;
    for (var item in cartItems) {
      saved += item.savedAmount * item.quantity.value;
    }
    return saved;
  }

  double get deliveryCharge => cartItems.isEmpty ? 0.0 : 10.0;
  
  double get totalAmount => subTotal + deliveryCharge;
  
  int get totalItems {
    int total = 0;
    for (var item in cartItems) {
      total += item.quantity.value;
    }
    return total;
  }
}
