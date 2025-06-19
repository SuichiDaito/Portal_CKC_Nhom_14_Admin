import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildInfoRow(
  String label,
  TextEditingController controller,
  bool isEnabled, {
  TextInputType keyboardType = TextInputType.text,
  IconData? icon, // Thêm icon nếu cần
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            enabled: isEnabled,
            keyboardType: keyboardType,
            inputFormatters: keyboardType == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 10.0,
              ),
              prefixIcon: icon != null
                  ? Icon(icon, color: Colors.blueAccent, size: 20)
                  : null,
              border: isEnabled ? const OutlineInputBorder() : InputBorder.none,
              filled: true,
              fillColor: isEnabled
                  ? Colors.white
                  : const Color.fromARGB(255, 244, 235, 235),
            ),
            style: TextStyle(
              color: isEnabled ? Colors.black : Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}
