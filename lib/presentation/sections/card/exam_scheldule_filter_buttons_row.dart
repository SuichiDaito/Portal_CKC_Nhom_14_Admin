import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/exam_schedule_card.dart';

class FilterButtonsRow extends StatelessWidget {
  final ExamStatus? currentFilter;
  final ValueChanged<ExamStatus?> onFilterChanged;

  const FilterButtonsRow({
    Key? key,
    required this.currentFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterButton('Tất cả', null),
            const SizedBox(width: 8),
            _buildFilterButton('Đã lên lịch', ExamStatus.scheduled),
            const SizedBox(width: 8),
            _buildFilterButton('Đã hoàn thành', ExamStatus.completed),
            const SizedBox(width: 8),
            _buildFilterButton('Đã hủy', ExamStatus.cancelled),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, ExamStatus? status) {
    final bool isSelected = currentFilter == status;
    return CustomButton(
      text: text,
      onPressed: () => onFilterChanged(status),
      backgroundColor: isSelected ? Colors.blueAccent : Colors.grey.shade300,
      textColor: isSelected ? Colors.white : Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      borderRadius: BorderRadius.circular(20), // Nút bo tròn
    );
  }
}
