import 'package:flutter/material.dart';

class CardInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool obscureText;

  const CardInputField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            counterText: "",
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF6FAE3D)),
            ),
          ),
        ),
      ],
    );
  }
}
