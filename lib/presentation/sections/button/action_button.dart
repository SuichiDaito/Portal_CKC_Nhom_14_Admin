import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onExit;

  const ActionButtons({super.key, required this.onSave, required this.onExit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.save, color: Colors.white),
            label: const Text("Lưu"),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onExit,
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            label: const Text("Thoát", style: TextStyle(color: Colors.white)),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.blue.shade400,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
