import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderHomeAdminSection extends StatefulWidget {
  final String? nameLogin;
  const HeaderHomeAdminSection({super.key, required this.nameLogin});

  @override
  State<HeaderHomeAdminSection> createState() => _HeaderHomeAdminSection();
}

class _HeaderHomeAdminSection extends State<HeaderHomeAdminSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Cho đẹp hơn
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào, ${widget.nameLogin}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Chào mừng đến với hệ thống quản lý',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[600], size: 30),
          ),
        ],
      ),
    );
  }
}
