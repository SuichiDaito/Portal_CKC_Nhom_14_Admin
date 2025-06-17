import 'package:flutter/material.dart';

class CustomAppBarTitle extends StatelessWidget {
  final String title;

  const CustomAppBarTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
