import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thoi_khoa_bieu_bloc.dart';
import 'package:portal_ckc/bloc/event/thoi_khoa_bieu_event.dart';
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
            Autocomplete<DropdownItem>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return weeks.where((DropdownItem option) {
                  return option.label.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  );
                });
              },
              displayStringForOption: (DropdownItem option) => option.label,
              fieldViewBuilder:
                  (
                    BuildContext context,
                    TextEditingController textController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted,
                  ) {
                    return TextField(
                      controller: textController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: 'Chép từ tuần',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
              onSelected: (DropdownItem selected) {
                selectedSourceWeekId = int.tryParse(selected.value);
              },
            ),
            const SizedBox(height: 12),
            Autocomplete<DropdownItem>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return weeks.where((DropdownItem option) {
                  return option.label.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  );
                });
              },
              displayStringForOption: (DropdownItem option) => option.label,
              fieldViewBuilder:
                  (
                    BuildContext context,
                    TextEditingController textController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted,
                  ) {
                    return TextField(
                      controller: textController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: 'Đến tuần',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
              onSelected: (DropdownItem selected) {
                print("=====${selected.value}=====");
                selectedTargetWeekId = int.tryParse(selected.value);
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

              // Sau khi sao chép xong, reload tuần hiện tại
              context.read<ThoiKhoaBieuBloc>().add(FetchThoiKhoaBieuEvent());
              Navigator.pop(context);
            },
            child: const Text('Xác nhận'),
          ),
        ],
      );
    },
  );
}
