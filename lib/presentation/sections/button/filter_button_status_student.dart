import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class FilterButtonsRow extends StatelessWidget {
  final StudentStatus? currentFilter;
  final ValueChanged<StudentStatus?> onFilterChanged;

  const FilterButtonsRow({
    Key? key,
    required this.currentFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  String _getStatusText(StudentStatus status) {
    switch (status) {
      case StudentStatus.active:
        return 'Đang học';
      case StudentStatus.inactive:
        return 'Nghỉ học';
      case StudentStatus.graduated:
        return 'Đã tốt nghiệp';
      case StudentStatus.suspended:
        return 'Đình chỉ';
    }
  }

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
            _buildFilterButton(
              _getStatusText(StudentStatus.active),
              StudentStatus.active,
            ),
            const SizedBox(width: 8),
            _buildFilterButton(
              _getStatusText(StudentStatus.inactive),
              StudentStatus.inactive,
            ),
            const SizedBox(width: 8),
            _buildFilterButton(
              _getStatusText(StudentStatus.graduated),
              StudentStatus.graduated,
            ),
            const SizedBox(width: 8),
            _buildFilterButton(
              _getStatusText(StudentStatus.suspended),
              StudentStatus.suspended,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, StudentStatus? status) {
    final bool isSelected = currentFilter == status;
    return CustomButton(
      text: text,
      onPressed: () => onFilterChanged(status),
      backgroundColor: isSelected ? Colors.blueAccent : Colors.grey.shade300,
      textColor: isSelected ? Colors.white : Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
