import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';

class DropdownSelector extends StatelessWidget {
  final String label;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final ValueChanged<DropdownItem?> onChanged;
  final bool isEnabled;

  const DropdownSelector({
    Key? key,
    required this.label,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isEnabled ? Colors.blueGrey : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: isEnabled ? Colors.blueAccent : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(8),
              color: isEnabled ? Colors.white : Colors.grey.shade100,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DropdownItem>(
                isExpanded: true,
                value: selectedItem,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: isEnabled ? Colors.blueAccent : Colors.grey,
                ),
                onChanged: isEnabled ? onChanged : null,
                items: items.map((item) {
                  return DropdownMenuItem<DropdownItem>(
                    value: item,
                    child: Text(
                      item.label,
                      style: TextStyle(
                        color: isEnabled ? Colors.black : Colors.grey.shade700,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
