import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/core/widgets/custom_text_field.dart';
import 'package:fruit_market/features/profile/presentation/controllers/profile_controller.dart';

class ChangeAddressView extends StatelessWidget {
  const ChangeAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final addressController = TextEditingController(text: controller.address.value);

    return Scaffold(
      appBar: const CustomAppBar(title: "Change Address"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF6FAE3D).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Color(0xFF6FAE3D)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Current Address",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                          controller.address.value,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "New Address",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: addressController,
              labelText: "Address",
              hintText: "Enter your new delivery address",
              prefixIcon: Icons.location_on_outlined,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            const CustomTextField(
              labelText: "City",
              hintText: "Enter city",
              prefixIcon: Icons.location_city,
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    labelText: "State",
                    hintText: "State",
                    prefixIcon: Icons.map,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    labelText: "Zip Code",
                    hintText: "12345",
                    prefixIcon: Icons.pin,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: "UPDATE ADDRESS",
              onPressed: () {
                if (addressController.text.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Please enter a valid address",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                controller.updateProfile(newAddress: addressController.text);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
