import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Language"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLanguageTile("English", true),
          _buildLanguageTile("Arabic", false),
          _buildLanguageTile("Spanish", false),
          _buildLanguageTile("Hindi", false),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(String title, bool isSelected) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.w400)),
      trailing: isSelected ? const Icon(Icons.check_circle, color: Color(0xFF6FAE3D)) : null,
      onTap: () {},
    );
  }
}
