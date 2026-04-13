import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/utils/size_config.dart';

class PaymentLoadingView extends StatefulWidget {
  const PaymentLoadingView({super.key});

  @override
  State<PaymentLoadingView> createState() => _PaymentLoadingViewState();
}

class _PaymentLoadingViewState extends State<PaymentLoadingView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/home'); // Or Success Screen if we have one
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6FAE3D)),
            ),
            SizedBox(height: getProportionateScreenHeight(24)),
            const Text(
              "Please Wait...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(8)),
            const Text(
              "We're processing your payment",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
