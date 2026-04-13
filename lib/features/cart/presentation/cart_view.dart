import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/utils/size_config.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/features/cart/presentation/controllers/cart_controller.dart';
import 'package:fruit_market/widgets/cart_item_widget.dart';
import 'package:fruit_market/widgets/price_summary_widget.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());

    return Scaffold(
      appBar: const CustomAppBar(title: "Shopping Cart", showBackButton: false),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  "Your cart is empty",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Add products to your cart to continue",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Get.toNamed('/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6FAE3D),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Start Shopping",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
              child: ListView(
                padding: EdgeInsets.only(bottom: getProportionateScreenHeight(200)),
                children: [
                  SizedBox(height: getProportionateScreenHeight(16)),
                  _buildAddressSection(controller),
                  SizedBox(height: getProportionateScreenHeight(24)),
                  
                  Obx(() => controller.vegetableItems.isNotEmpty
                      ? _buildProductGroup("Vegetables", controller.vegetableItems, controller)
                      : const SizedBox()),
                  
                  SizedBox(height: getProportionateScreenHeight(16)),
                  
                  Obx(() => controller.dryFruitItems.isNotEmpty
                      ? _buildProductGroup("Dry Fruits", controller.dryFruitItems, controller)
                      : const SizedBox()),
                  
                  Obx(() => controller.fruitsItems.isNotEmpty
                      ? _buildProductGroup("Fruits", controller.fruitsItems, controller)
                      : const SizedBox()),
                ],
              ),
            ),
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PriceSummaryWidget(
                        subTotal: controller.subTotal,
                        discount: controller.totalSavings,
                        deliveryCharge: controller.deliveryCharge,
                        total: controller.totalAmount,
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                        child: CustomButton(
                          text: "PLACE ORDER (\$${controller.totalAmount.toStringAsFixed(2)})",
                          onPressed: () {
                            if (controller.cartItems.isEmpty) {
                              Get.snackbar(
                                "Cart Empty",
                                "Please add items to your cart",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              Get.toNamed('/payment-method');
                            }
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAddressSection(CartController controller) {
    return GestureDetector(
      onTap: () => Get.toNamed('/change-address'),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(16)),
        decoration: BoxDecoration(
          color: const Color(0xFF6FAE3D).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFF6FAE3D)),
            SizedBox(width: getProportionateScreenWidth(12)),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Address",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    "123 Street Name, City, Country",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGroup(String title, List<CartItem> items, CartController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "${items.length} items",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(12)),
        ...items.map((item) => Obx(() => CartItemWidget(
              title: item.product.name,
              image: item.product.image,
              currentPrice: item.product.price,
              oldPrice: item.oldPrice,
              savedAmount: item.savedAmount,
              quantity: item.quantity.value,
              onIncrement: () => controller.incrementQuantity(item.product.id),
              onDecrement: () => controller.decreaseQuantity(item.product.id),
              onDelete: () {
                Get.defaultDialog(
                  title: "Remove Item",
                  middleText: "Are you sure you want to remove ${item.product.name} from cart?",
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.red,
                  onConfirm: () {
                    controller.removeFromCart(item.product.id);
                    Get.back();
                  },
                );
              },
            ))),
      ],
    );
  }
}
