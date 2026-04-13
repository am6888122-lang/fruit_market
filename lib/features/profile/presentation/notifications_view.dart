import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Notifications"),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (context, index) => const Divider(height: 32),
        itemBuilder: (context, index) {
          return const NotificationTile();
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF6FAE3D).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.notifications_outlined, color: Color(0xFF6FAE3D), size: 24),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fresh fruits available in stock!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                "Get fresh fruits from our new stock now with 10% discount.",
                style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
              ),
              SizedBox(height: 8),
              Text(
                "2 hours ago",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
