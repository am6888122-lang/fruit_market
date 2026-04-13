import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/features/home/presentation/controllers/home_controller.dart';
import 'package:fruit_market/features/home/presentation/home_view.dart';
import 'package:fruit_market/features/favorites/presentation/favorites_view.dart';
import 'package:fruit_market/features/cart/presentation/cart_view.dart';
import 'package:fruit_market/features/profile/presentation/profile_view.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    final List<Widget> pages = [
      const HomeView(),
      const FavoritesView(),
      const CartView(),
      const ProfileView(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.changeIndex(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF6FAE3D),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: "Favorites"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), activeIcon: Icon(Icons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: "Account"),
          ],
        ),
      ),
    );
  }
}
