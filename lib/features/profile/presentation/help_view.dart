import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Help Center"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.help_center_outlined, size: 80, color: Color(0xFF6FAE3D)),
            const SizedBox(height: 24),
            const Text(
              "How can we help you?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "We're here to help you. Select one of the categories below to get started.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 48),
            _buildHelpTile(Icons.assignment_outlined, "FAQs"),
            const SizedBox(height: 16),
            _buildHelpTile(Icons.mail_outline, "Email Support"),
            const SizedBox(height: 16),
            _buildHelpTile(Icons.chat_bubble_outline, "Live Chat"),
            const SizedBox(height: 16),
            _buildHelpTile(Icons.phone_outlined, "Phone Support"),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpTile(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6FAE3D)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
