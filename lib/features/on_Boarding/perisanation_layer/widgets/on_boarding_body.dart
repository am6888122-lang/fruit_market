import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/widgets/custom_buttons.dart';
import 'package:fruit_market/features/on_Boarding/perisanation_layer/widgets/custom_pageview.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPageview(
          pageController: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 250,
          child: PageViewDotIndicator(
            currentItem: _currentPage,
            count: 3,
            unselectedColor: Colors.black26,
            selectedColor: const Color(0xFF6FAE3D),
          ),
        ),
        if (_currentPage < 2)
          Positioned(
            top: 60,
            right: 24,
            child: GestureDetector(
              onTap: () {
                Get.offAllNamed('/login');
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        Positioned(
          left: 60,
          right: 60,
          bottom: 80,
          child: CustomButton(
            text: _currentPage == 2 ? "Get started" : "Next",
            onPressed: _nextPage,
          ),
        ),
      ],
    );
  }
}
