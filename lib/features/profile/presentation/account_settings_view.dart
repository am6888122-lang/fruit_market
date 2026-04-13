import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/core/widgets/custom_text_field.dart';
import 'package:fruit_market/features/profile/presentation/controllers/profile_controller.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final nameController = TextEditingController(text: controller.name.value);
    final emailController = TextEditingController(text: controller.email.value);
    final phoneController = TextEditingController(text: controller.phone.value);

    return Scaffold(
      appBar: const CustomAppBar(title: "Account Settings"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Stack(
              children: [
                Obx(() => CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xFFE8F5E9),
                  backgroundImage: controller.imagePath.value.isNotEmpty
                      ? NetworkImage(controller.imagePath.value)
                      : null,
                  child: controller.imagePath.value.isEmpty
                      ? const Icon(Icons.person, size: 60, color: Color(0xFF6FAE3D))
                      : null,
                )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        "Change Photo",
                        "Photo picker functionality will be implemented",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6FAE3D),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              "Edit Profile Picture",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6FAE3D),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 48),
            CustomTextField(
              controller: nameController,
              labelText: "Full Name",
              hintText: "Enter your full name",
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: emailController,
              labelText: "Email Address",
              hintText: "Enter your email",
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: phoneController,
              labelText: "Mobile Number",
              hintText: "Enter your phone number",
              prefixIcon: Icons.phone_android,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: "SAVE CHANGES",
              onPressed: () {
                if (nameController.text.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Name cannot be empty",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }
                
                if (emailController.text.isEmpty || !emailController.text.contains('@')) {
                  Get.snackbar(
                    "Error",
                    "Please enter a valid email",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                controller.updateProfile(
                  newName: nameController.text,
                  newEmail: emailController.text,
                  newPhone: phoneController.text,
                );
                
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
