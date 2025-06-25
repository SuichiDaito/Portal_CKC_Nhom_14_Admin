import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const NumberField({
    super.key,
    required this.label,
    required this.controller,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.remove), onPressed: onMinus),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            IconButton(icon: const Icon(Icons.add), onPressed: onPlus),
          ],
        ),
      ],
    );
  }
}
