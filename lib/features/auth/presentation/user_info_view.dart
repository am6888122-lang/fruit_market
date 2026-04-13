import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/core/widgets/custom_text_field.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("User Info", style: TextStyle(color: Colors.black)),
        centerTitle: true,
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
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(Icons.camera_alt, size: 40, color: Color(0xFF6FAE3D)),
            ),
            const SizedBox(height: 12),
            const Text(
              "Add Profile Picture",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6FAE3D),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 48),
            const CustomTextField(
              hintText: "Full Name",
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              hintText: "Address",
              prefixIcon: Icons.location_on,
              maxLines: 3,
            ),
            const SizedBox(height: 100),
            CustomButton(
              text: "START EXPLORING",
              onPressed: () {
                Get.offAllNamed('/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
