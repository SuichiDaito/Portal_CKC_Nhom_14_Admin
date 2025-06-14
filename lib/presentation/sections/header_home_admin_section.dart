import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderHomeAdminSection extends StatefulWidget {
  final nameLogin;
  const HeaderHomeAdminSection({super.key, required this.nameLogin});
  State<HeaderHomeAdminSection> createState() => _HeaderHomeAdminSection();
}

class _HeaderHomeAdminSection extends State<HeaderHomeAdminSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xin chào, ${widget.nameLogin}',
                style: TextStyle(
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
