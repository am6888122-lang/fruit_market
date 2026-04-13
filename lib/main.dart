import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fruit_market/features/favorites/presentation/favorites_view.dart';
import 'package:get/get.dart';
import 'package:fruit_market/features/splash/presantatoin_layer/splash_view.dart';
import 'package:fruit_market/features/on_Boarding/perisanation_layer/on_boarding_view.dart';
import 'package:fruit_market/features/auth/presentation/login_view.dart';
import 'package:fruit_market/features/auth/presentation/otp_view.dart';
import 'package:fruit_market/features/auth/presentation/verification_success_view.dart';
import 'package:fruit_market/features/auth/presentation/user_info_view.dart';
import 'package:fruit_market/features/home/presentation/main_layout.dart';
import 'package:fruit_market/features/home/presentation/product_details_view.dart';
import 'package:fruit_market/features/profile/presentation/orders_view.dart';
import 'package:fruit_market/features/profile/presentation/notifications_view.dart';
import 'package:fruit_market/features/profile/presentation/notification_settings_view.dart';
import 'package:fruit_market/features/profile/presentation/language_view.dart';
import 'package:fruit_market/features/profile/presentation/help_view.dart';
import 'package:fruit_market/features/profile/presentation/account_settings_view.dart';
import 'package:fruit_market/features/profile/presentation/change_address_view.dart';
import 'package:fruit_market/features/cart/presentation/cart_view.dart';
import 'package:fruit_market/features/cart/presentation/payment_method_view.dart';
import 'package:fruit_market/features/cart/presentation/add_card_view.dart';
import 'package:fruit_market/features/cart/presentation/payment_loading_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruit Market',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF6FAE3D),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const FruitMarketSplash()),
        GetPage(name: '/onboarding', page: () => const OnBoardingView()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/otp', page: () => const OTPView()),
        GetPage(
          name: '/verification-success',
          page: () => const VerificationSuccessView(),
        ),
        GetPage(name: '/user-info', page: () => const UserInfoView()),
        GetPage(name: '/home', page: () => const MainLayout()),
        GetPage(
          name: '/product-details',
          page: () => const ProductDetailsView(),
        ),
        GetPage(name: '/orders', page: () => const OrdersView()),
        GetPage(name: '/notifications', page: () => const NotificationsView()),
        GetPage(
          name: '/notification-settings',
          page: () => const NotificationSettingsView(),
        ),
        GetPage(name: '/languages', page: () => const LanguageView()),
        GetPage(name: '/help', page: () => const HelpView()),
        GetPage(
          name: '/account-settings',
          page: () => const AccountSettingsView(),
        ),
        GetPage(name: '/change-address', page: () => const ChangeAddressView()),
        GetPage(name: '/favorites', page: () => const FavoritesView()),
        GetPage(name: '/cart', page: () => const CartView()),
        GetPage(name: '/payment-method', page: () => const PaymentMethodView()),
        GetPage(name: '/add-card', page: () => const AddCardView()),
        GetPage(
          name: '/payment-loading',
          page: () => const PaymentLoadingView(),
        ),
      ],
    );
  }
}
