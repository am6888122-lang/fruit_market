import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';
import 'package:fruit_market/features/profile/presentation/controllers/profile_controller.dart';

class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: const CustomAppBar(title: "Notification Settings"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF6FAE3D).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF6FAE3D)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Manage your notification preferences",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => _buildSwitchTile(
            "Push Notifications",
            "Receive push notifications on your device",
            controller.notificationsEnabled.value,
            (val) => controller.toggleNotifications(val),
          )),
          Obx(() => _buildSwitchTile(
            "Order Updates",
            "Get notified about your order status",
            controller.orderUpdatesEnabled.value,
            (val) => controller.toggleOrderUpdates(val),
          )),
          Obx(() => _buildSwitchTile(
            "Offers & Promotions",
            "Receive special offers and promotions",
            controller.promotionsEnabled.value,
            (val) => controller.togglePromotions(val),
          )),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF6FAE3D),
      ),
    );
  }
}
