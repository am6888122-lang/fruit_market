import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';
import 'package:fruit_market/features/profile/presentation/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: const CustomAppBar(title: "Account", showBackButton: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          children: [
            Obx(() => Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xFFE8F5E9),
                        backgroundImage: controller.imagePath.value.isNotEmpty
                            ? NetworkImage(controller.imagePath.value)
                            : null,
                        child: controller.imagePath.value.isEmpty
                            ? const Icon(Icons.person, size: 50, color: Color(0xFF6FAE3D))
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Get.snackbar(
                              "Change Photo",
                              "Photo picker will be implemented",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6FAE3D),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    controller.name.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.email.value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 40),
            _buildProfileSection([
              ProfileMenuItem(
                icon: Icons.person_outline,
                title: "My Profile",
                onTap: () => Get.toNamed('/account-settings'),
              ),
              ProfileMenuItem(
                icon: Icons.shopping_bag_outlined,
                title: "My Orders",
                badge: "3",
                onTap: () => Get.toNamed('/orders'),
              ),
              ProfileMenuItem(
                icon: Icons.favorite_outline,
                title: "Favorites",
                onTap: () => Get.toNamed('/favorites'),
              ),
              ProfileMenuItem(
                icon: Icons.notifications_none,
                title: "Notifications",
                badge: "5",
                onTap: () => Get.toNamed('/notification-settings'),
              ),
            ]),
            const SizedBox(height: 24),
            _buildProfileSection([
              ProfileMenuItem(
                icon: Icons.language,
                title: "Language",
                subtitle: "English",
                onTap: () => Get.toNamed('/languages'),
              ),
              Obx(() => ProfileMenuItem(
                icon: Icons.location_on_outlined,
                title: "Delivery Address",
                subtitle: controller.address.value,
                onTap: () => Get.toNamed('/change-address'),
              )),
              ProfileMenuItem(
                icon: Icons.help_outline,
                title: "Help Center",
                onTap: () => Get.toNamed('/help'),
              ),
            ]),
            const SizedBox(height: 24),
            _buildProfileSection([
              ProfileMenuItem(
                icon: Icons.logout,
                title: "Log Out",
                iconColor: Colors.red,
                textColor: Colors.red,
                onTap: () {
                  Get.defaultDialog(
                    title: "Logout",
                    middleText: "Are you sure you want to logout?",
                    textConfirm: "Yes",
                    textCancel: "No",
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.red,
                    onConfirm: () {
                      Get.back();
                      Get.offAllNamed('/login');
                      Get.snackbar(
                        "Logged Out",
                        "You have been logged out successfully",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  );
                },
              ),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(List<Widget> items) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? badge;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.badge,
    required this.onTap,
    this.iconColor = const Color(0xFF6FAE3D),
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          if (badge != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
