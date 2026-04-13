import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/core/widgets/custom_text_field.dart';
import 'package:fruit_market/features/auth/presentation/controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset("assets/images/login_image.png", height: 250),
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter your mobile number to receive OTP",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              controller: authController.phoneController,
              hintText: "01234567890",
              labelText: "Mobile Number",
              prefixIcon: Icons.phone_android,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Phone Number Format",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "• Egypt: 01234567890 or +201234567890\n"
                    "• International: +1234567890\n"
                    "• Auto-adds +20 for Egyptian numbers",
                    style: TextStyle(fontSize: 11, color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Obx(
              () => authController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6FAE3D),
                      ),
                    )
                  : CustomButton(
                      text: "SEND OTP",
                      onPressed: () => authController.sendOTP(),
                    ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                      "Coming Soon",
                      "Sign up feature is under development",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xFF6FAE3D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
