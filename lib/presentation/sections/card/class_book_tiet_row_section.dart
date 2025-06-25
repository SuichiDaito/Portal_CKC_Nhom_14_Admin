import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/class_boox_number_field.dart';

class TietRowSection extends StatelessWidget {
  final TextEditingController tietTuController;
  final TextEditingController tietDenController;
  final VoidCallback onTietTuMinus;
  final VoidCallback onTietTuPlus;
  final VoidCallback onTietDenMinus;
  final VoidCallback onTietDenPlus;

  const TietRowSection({
    super.key,
    required this.tietTuController,
    required this.tietDenController,
    required this.onTietTuMinus,
    required this.onTietTuPlus,
    required this.onTietDenMinus,
    required this.onTietDenPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NumberField(
            label: "Từ tiết",
            controller: tietTuController,
            onMinus: onTietTuMinus,
            onPlus: onTietTuPlus,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: NumberField(
            label: "Đến tiết",
            controller: tietDenController,
            onMinus: onTietDenMinus,
            onPlus: onTietDenPlus,
          ),
        ),
      ],
    );
  }
}
