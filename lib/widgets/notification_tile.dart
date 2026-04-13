import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
  });

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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 8),
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
