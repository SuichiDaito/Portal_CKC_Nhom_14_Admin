import 'package:flutter/material.dart';

class CustomDropdownRow extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final void Function(String?)? onChanged;

  const CustomDropdownRow({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text("$label:")),
        Expanded(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
