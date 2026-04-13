import 'package:flutter/material.dart';
import 'package:fruit_market/core/utils/size_config.dart';

class PaymentMethodTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? const Color(0xFF6FAE3D) : Colors.grey.shade200,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: getProportionateScreenWidth(40),
          height: getProportionateScreenHeight(40),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(child: Icon(Icons.payment, size: 24, color: Colors.grey)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: subtitle != null
            ? Text(subtitle!, style: const TextStyle(color: Colors.grey, fontSize: 12))
            : null,
        trailing: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? const Color(0xFF6FAE3D) : Colors.grey,
              width: 2,
            ),
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6FAE3D),
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
