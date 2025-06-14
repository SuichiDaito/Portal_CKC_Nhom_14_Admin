import 'package:flutter/material.dart';

class ButtonLogOutInUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.logout),
      label: const Text('Đăng xuất'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff347433),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
  }
}
