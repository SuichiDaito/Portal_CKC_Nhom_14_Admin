import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/class_boox_number_field.dart';

class SiSoRowSection extends StatelessWidget {
  final TextEditingController siSoController;
  final TextEditingController hienDienController;
  final VoidCallback onHienDienMinus;
  final VoidCallback onHienDienPlus;

  const SiSoRowSection({
    super.key,
    required this.siSoController,
    required this.hienDienController,
    required this.onHienDienMinus,
    required this.onHienDienPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sĩ số'),
              TextFormField(
                controller: siSoController,
                readOnly: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: NumberField(
            label: "Hiện diện",
            controller: hienDienController,
            onMinus: onHienDienMinus,
            onPlus: onHienDienPlus,
          ),
        ),
      ],
    );
  }
}
