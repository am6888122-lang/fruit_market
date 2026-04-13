import 'package:flutter/material.dart';
import 'package:fruit_market/core/utils/size_config.dart';

class PageviewCustomItmes extends StatelessWidget {
  const PageviewCustomItmes({
    super.key,
    this.titel,
    this.subtitle,
    this.images,
  });
  final String? titel;
  final String? subtitle;
  final String? images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(150)),
        SizedBox(
          height: getProportionateScreenHeight(250),
          child: Image.asset(images!),
        ),
        SizedBox(height: getProportionateScreenHeight(40)),
        Text(
          titel!,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2F2E41),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
