import 'package:flutter/material.dart';
import 'package:fruit_market/features/on_Boarding/perisanation_layer/widgets/pageview_custom_itmes.dart';

class CustomPageview extends StatelessWidget {
  const CustomPageview({
    super.key,
    required this.pageController,
    required this.onPageChanged,
  });

  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: onPageChanged,
      children: [
        PageviewCustomItmes(
          images: "assets/images/onboarding1.png",
          titel: "E Shopping",
          subtitle: "Explore top organic fruits & grab them",
        ),
        PageviewCustomItmes(
          images: 'assets/images/onboarding2.png',
          titel: 'Delivery on the way',
          subtitle: 'Get your order by speed delivery',
        ),
        PageviewCustomItmes(
          images: 'assets/images/onboarding3.png',
          titel: 'Delivery Arrived',
          subtitle: 'Order is arrived at your place',
        ),
      ],
    );
  }
}
