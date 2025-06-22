import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';

class DropdownSelector extends StatelessWidget {
  final String label;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final ValueChanged<DropdownItem?> onChanged;

  const DropdownSelector({
    Key? key,
    required this.label,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<DropdownItem>(
            isExpanded: true,
            value: selectedItem,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
            onChanged: onChanged,
            items: items.map((item) {
              return DropdownMenuItem<DropdownItem>(
                value: item,
                child: Row(
                  children: [
                    Icon(item.icon, size: 20, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Text(item.label),
                  ],
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
