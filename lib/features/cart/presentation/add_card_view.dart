import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/utils/size_config.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/widgets/card_input_field.dart';

class AddCardView extends StatelessWidget {
  const AddCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Card"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            // Credit Card Image
            Container(
              height: getProportionateScreenHeight(200),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6FAE3D), Color(0xFF4C8C2B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6FAE3D).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    right: 30,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 15,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "**** **** **** 1234",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Ahmed Mansour",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              "12/26",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: getProportionateScreenHeight(40)),
            
            // Input Fields
            const CardInputField(
              label: "Cardholder Name",
              hint: "Ahmed Mansour",
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: CardInputField(label: "Card Number", hint: "****")),
                SizedBox(width: 8),
                Expanded(child: CardInputField(label: "", hint: "****")),
                SizedBox(width: 8),
                Expanded(child: CardInputField(label: "", hint: "****")),
                SizedBox(width: 8),
                Expanded(child: CardInputField(label: "", hint: "****")),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            
            Row(
              children: [
                const Expanded(child: CardInputField(label: "Exp. Date", hint: "MM / YY")),
                SizedBox(width: getProportionateScreenWidth(20)),
                const Expanded(child: CardInputField(label: "CVV", hint: "***", obscureText: true)),
              ],
            ),
            
            SizedBox(height: getProportionateScreenHeight(60)),
            
            CustomButton(
              text: "ADD CARD NUMBER",
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}
