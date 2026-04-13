import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/custom_app_bar.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "My Orders"),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const OrderCard();
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Icon(Icons.image, color: Colors.grey)),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order #12345", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Placed on 20 July, 2024", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              const Text(
                "Delivered",
                style: TextStyle(color: Color(0xFF6FAE3D), fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 32),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount", style: TextStyle(color: Colors.grey)),
              Text("\$120.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
