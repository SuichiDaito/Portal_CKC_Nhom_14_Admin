import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';

class InfoRowDropdown extends StatelessWidget {
  final String label;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final ValueChanged<DropdownItem?> onChanged;
  final bool isEditing;

  const InfoRowDropdown({
    Key? key,
    required this.label,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    required this.isEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validSelectedItem = items.any((e) => e.value == selectedItem?.value)
        ? selectedItem
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Text(label, style: const TextStyle(fontSize: 14)),
            ),
          ),
          Expanded(
            child: DropdownButtonFormField<DropdownItem>(
              value: validSelectedItem,
              isExpanded: true,
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.label,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: isEditing ? onChanged : null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
