import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/features/auth/presentation/controllers/auth_controller.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone Verification",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(() => Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter the 6-digit code sent to\n${authController.phoneNumber.value}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                )),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => _buildOTPBox(context, authController, index),
              ),
            ),
            const SizedBox(height: 50),
            Obx(() => authController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6FAE3D),
                    ),
                  )
                : CustomButton(
                    text: "VERIFY",
                    onPressed: () => authController.verifyOTP(),
                  )),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't receive the code? ",
                  style: TextStyle(color: Colors.grey),
                ),
                Obx(() => authController.isLoading.value
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () => authController.resendOTP(),
                        child: const Text(
                          "Resend",
                          style: TextStyle(
                            color: Color(0xFF6FAE3D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.timer_outlined, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Code expires in 60 seconds. Check your SMS inbox.",
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPBox(
      BuildContext context, AuthController controller, int index) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        controller: controller.otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF6FAE3D),
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
