import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(Icons.remove, size: 16, color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF6FAE3D).withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(Icons.add, size: 16, color: Color(0xFF6FAE3D)),
          ),
        ),
      ],
    );
  }
}
