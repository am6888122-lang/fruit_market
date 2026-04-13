import 'package:flutter/material.dart';
import 'package:fruit_market/core/utils/size_config.dart';

class CartItemWidget extends StatelessWidget {
  final String title;
  final String image;
  final double currentPrice;
  final double oldPrice;
  final double savedAmount;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.title,
    required this.image,
    required this.currentPrice,
    required this.oldPrice,
    required this.savedAmount,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: getProportionateScreenHeight(70),
            width: getProportionateScreenWidth(80),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(child: Icon(Icons.image, color: Colors.grey)),
          ),
          SizedBox(width: getProportionateScreenWidth(12)),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: onDelete,
                      child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(4)),
                Row(
                  children: [
                    Text(
                      "\$$oldPrice",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(8)),
                    Text(
                      "Saved \$$savedAmount",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6FAE3D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$$currentPrice",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    // Quantity Control
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onDecrement,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.remove, size: 18, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "$quantity",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: onIncrement,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6FAE3D).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.add, size: 18, color: Color(0xFF6FAE3D)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
