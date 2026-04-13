import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';

class VerificationSuccessView extends StatelessWidget {
  const VerificationSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Color(0xFF6FAE3D),
              ),
              const SizedBox(height: 24),
              const Text(
                "Phone Verified!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Congratulations, your phone number has been verified. You can start using the application.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 100),
              CustomButton(
                text: "CONTINUE",
                onPressed: () {
                  Get.offAllNamed('/user-info');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
