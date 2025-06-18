import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_academic_year_management.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class FilterStatusButtons extends StatelessWidget {
  final AcademicYearStatus? currentFilter;
  final ValueChanged<AcademicYearStatus?> onFilterChanged;

  const FilterStatusButtons({
    Key? key,
    required this.currentFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  String _getStatusText(AcademicYearStatus status) {
    switch (status) {
      case AcademicYearStatus.initialized:
        return 'Đã khởi tạo';
      case AcademicYearStatus.notInitialized:
        return 'Chưa khởi tạo';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton('Tất cả', null),
          const SizedBox(width: 8),
          _buildFilterButton(
            _getStatusText(AcademicYearStatus.initialized),
            AcademicYearStatus.initialized,
          ),
          const SizedBox(width: 8),
          _buildFilterButton(
            _getStatusText(AcademicYearStatus.notInitialized),
            AcademicYearStatus.notInitialized,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, AcademicYearStatus? status) {
    final bool isSelected = currentFilter == status;
    return Expanded(
      child: CustomButton(
        text: text,
        onPressed: () => onFilterChanged(status),
        backgroundColor: isSelected ? Colors.blueAccent : Colors.grey.shade300,
        textColor: isSelected ? Colors.white : Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
