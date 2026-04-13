import 'package:flutter/material.dart';
import 'package:fruit_market/core/utils/size_config.dart';

class PriceSummaryWidget extends StatelessWidget {
  final double subTotal;
  final double discount;
  final double deliveryCharge;
  final double total;

  const PriceSummaryWidget({
    super.key,
    required this.subTotal,
    required this.discount,
    required this.deliveryCharge,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getProportionateScreenWidth(20)),
          topRight: Radius.circular(getProportionateScreenWidth(20)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPriceRow("Sub Total", subTotal),
          SizedBox(height: getProportionateScreenHeight(8)),
          _buildPriceRow("Discount", discount, isNegative: true),
          SizedBox(height: getProportionateScreenHeight(8)),
          _buildPriceRow("Delivery Charge", deliveryCharge),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$$total",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6FAE3D),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isNegative = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Text(
          "${isNegative ? '-' : ''}\$$amount",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }
}
