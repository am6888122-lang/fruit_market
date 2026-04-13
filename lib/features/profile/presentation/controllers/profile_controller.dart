import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = "Ahmed Mansour".obs;
  var email = "ahmed.mansour@example.com".obs;
  var phone = "+20 123 456 7890".obs;
  var address = "123 Street Name, City, Country".obs;
  var imagePath = "".obs;
  var notificationsEnabled = true.obs;
  var orderUpdatesEnabled = true.obs;
  var promotionsEnabled = false.obs;

  void updateProfile({
    String? newName,
    String? newEmail,
    String? newPhone,
    String? newAddress,
    String? newImage,
  }) {
    if (newName != null) name.value = newName;
    if (newEmail != null) email.value = newEmail;
    if (newPhone != null) phone.value = newPhone;
    if (newAddress != null) address.value = newAddress;
    if (newImage != null) imagePath.value = newImage;

    Get.snackbar(
      "Profile Updated",
      "Your profile has been updated successfully",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
    Get.snackbar(
      "Notifications ${value ? 'Enabled' : 'Disabled'}",
      "Push notifications have been ${value ? 'enabled' : 'disabled'}",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void toggleOrderUpdates(bool value) {
    orderUpdatesEnabled.value = value;
  }

  void togglePromotions(bool value) {
    promotionsEnabled.value = value;
  }
}
