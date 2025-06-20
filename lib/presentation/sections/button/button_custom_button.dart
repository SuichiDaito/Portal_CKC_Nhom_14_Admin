import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final bool isEnabled;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.isEnabled = true, // Mặc định là bật
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null, // Disable if not enabled
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled
            ? backgroundColor
            : Colors.grey.shade400, // Màu khi disable
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 15)),
    );
  }
}
