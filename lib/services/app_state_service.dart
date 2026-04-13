import 'package:get/get.dart';
import 'package:fruit_market/features/cart/presentation/controllers/cart_controller.dart';
import 'package:fruit_market/features/favorites/presentation/controllers/favorite_controller.dart';
import 'package:fruit_market/features/profile/presentation/controllers/profile_controller.dart';

class AppStateService extends GetxService {
  late CartController cartController;
  late FavoriteController favoriteController;
  late ProfileController profileController;

  @override
  void onInit() {
    super.onInit();
    cartController = Get.put(CartController(), permanent: true);
    favoriteController = Get.put(FavoriteController(), permanent: true);
    profileController = Get.put(ProfileController(), permanent: true);
  }

  static AppStateService get to => Get.find();
}
