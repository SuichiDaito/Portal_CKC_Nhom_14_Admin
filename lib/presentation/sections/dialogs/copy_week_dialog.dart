import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

Future<void> showScheduleCopyDialog({
  required BuildContext context,
  required List<DropdownItem> weeks,
  required Function(int sourceWeekId, int targetWeekId) onCopy,
}) async {
  int? selectedSourceWeekId;
  int? selectedTargetWeekId;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Chọn tuần sao chép',
          style: TextStyle(color: Colors.blue),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownSelector(
              label: 'Chép từ tuần',
              selectedItem: weeks.firstOrNull,
              items: weeks,
              onChanged: (item) {
                selectedSourceWeekId = int.tryParse(item?.value ?? '');
              },
            ),
            const SizedBox(height: 12),
            DropdownSelector(
              label: 'Đến tuần',
              selectedItem: weeks.firstOrNull,
              items: weeks,
              onChanged: (item) {
                selectedTargetWeekId = int.tryParse(item?.value ?? '');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedSourceWeekId == null ||
                  selectedTargetWeekId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Vui lòng chọn đầy đủ tuần nguồn và tuần đích',
                    ),
                  ),
                );
                return;
              }

              onCopy(selectedSourceWeekId!, selectedTargetWeekId!);
              Navigator.pop(context);
            },
            child: const Text('Xác nhận'),
          ),
        ],
      );
    },
  );
}
