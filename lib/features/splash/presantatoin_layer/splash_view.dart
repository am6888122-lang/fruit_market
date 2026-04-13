// import 'package:flutter/material.dart';

// class FruitMarketSplash extends StatelessWidget {
//   const FruitMarketSplash({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(color: Color(0xFF6FAE3D)),
//         child: Stack(
//           children: [
//             Center(
//               child: Text(
//                 "Fruit Market",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 46,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Image.asset(
//                 "assets/images/splash_app.png",
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fruit_market/core/utils/size_config.dart';

class FruitMarketSplash extends StatefulWidget {
  const FruitMarketSplash({super.key});

  @override
  State<FruitMarketSplash> createState() => _FruitMarketSplashState();
}

class _FruitMarketSplashState extends State<FruitMarketSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    goToNextView();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void goToNextView() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Init SizeConfig
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF6FAE3D)),
        child: Stack(
          children: [
            /// Animated Text
            Center(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: const Text(
                    "Fruit Market",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/images/splash_app.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
