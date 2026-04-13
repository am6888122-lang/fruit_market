import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/utils/size_config.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/features/cart/presentation/controllers/cart_controller.dart';
import 'package:fruit_market/features/cart/presentation/controllers/payment_controller.dart';
import 'package:fruit_market/widgets/payment_method_tile.dart';

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: const CustomAppBar(title: "Payment Method"),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: ListView(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                // Bill Section
                _buildTotalBill(cartController.totalAmount),
                SizedBox(height: getProportionateScreenHeight(24)),
                
                // Summary Section
                const Text("Order Summary", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: getProportionateScreenHeight(16)),
                _buildSummaryLine("Items", "\$${cartController.subTotal}"),
                _buildSummaryLine("Delivery", "\$${cartController.deliveryCharge}"),
                _buildSummaryLine("Discount", "-\$${cartController.totalSavings}"),
                const Divider(),
                _buildSummaryLine("Grand Total", "\$${cartController.totalAmount}", isTotal: true),
                
                SizedBox(height: getProportionateScreenHeight(32)),
                
                // Payment Selection
                const Text("Select Payment Method", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: getProportionateScreenHeight(16)),
                
                Obx(() => Column(
                  children: [
                    PaymentMethodTile(
                      title: "Credit / Debit Cards",
                      subtitle: "${controller.cards.length} cards added",
                      image: "assets/images/card.png",
                      isSelected: controller.selectedMethod.value == "Credit Card",
                      onTap: () => controller.selectMethod("Credit Card"),
                    ),
                    if (controller.selectedMethod.value == "Credit Card")
                      _buildCardsList(controller),
                    
                    PaymentMethodTile(
                      title: "PhonePe",
                      image: "assets/images/phonepe.png",
                      isSelected: controller.selectedMethod.value == "PhonePe",
                      onTap: () => controller.selectMethod("PhonePe"),
                    ),
                    PaymentMethodTile(
                      title: "Google Pay",
                      image: "assets/images/gpay.png",
                      isSelected: controller.selectedMethod.value == "Google Pay",
                      onTap: () => controller.selectMethod("Google Pay"),
                    ),
                    PaymentMethodTile(
                      title: "PayPal",
                      image: "assets/images/paypal.png",
                      isSelected: controller.selectedMethod.value == "PayPal",
                      onTap: () => controller.selectMethod("PayPal"),
                    ),
                    PaymentMethodTile(
                      title: "Cash on Delivery",
                      image: "assets/images/cod.png",
                      isSelected: controller.selectedMethod.value == "COD",
                      onTap: () => controller.selectMethod("COD"),
                    ),
                  ],
                )),
                
                SizedBox(height: getProportionateScreenHeight(100)), // Space for fixed button
              ],
            ),
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              child: CustomButton(
                text: "PAY NOW",
                onPressed: () {
                  Get.toNamed('/payment-loading');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBill(double total) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF6FAE3D).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Total Bill Amount", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          Text("\$$total", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF6FAE3D))),
        ],
      ),
    );
  }

  Widget _buildSummaryLine(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 16 : 13, color: isTotal ? Colors.black : Colors.grey)),
          Text(value, style: TextStyle(fontSize: isTotal ? 16 : 13, fontWeight: isTotal ? FontWeight.bold : FontWeight.w500, color: isTotal ? const Color(0xFF6FAE3D) : Colors.black)),
        ],
      ),
    );
  }

  Widget _buildCardsList(PaymentController controller) {
    return Column(
      children: [
        ...controller.cards.map((card) => Padding(
          padding: const EdgeInsets.only(left: 32, bottom: 8),
          child: Row(
            children: [
              const Icon(Icons.credit_card, size: 16, color: Colors.grey),
              const SizedBox(width: 12),
              Text(card['number']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        )),
        TextButton.icon(
          onPressed: () => Get.toNamed('/add-card'),
          icon: const Icon(Icons.add, size: 16, color: Color(0xFF6FAE3D)),
          label: const Text("Add New Card", style: TextStyle(color: Color(0xFF6FAE3D), fontSize: 13)),
        ),
      ],
    );
  }
}
