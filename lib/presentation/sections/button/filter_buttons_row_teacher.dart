import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_teacher_management_admin.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class FilterButtonsRowTeacher extends StatelessWidget {
  final TeacherPosition? currentFilter;
  final ValueChanged<TeacherPosition?> onFilterChanged;

  const FilterButtonsRowTeacher({
    Key? key,
    required this.currentFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  String _getPositionText(TeacherPosition position) {
    switch (position) {
      case TeacherPosition.dean:
        return 'Trưởng khoa';
      case TeacherPosition.viceDean:
        return 'Phó khoa';
      case TeacherPosition.lecturer:
        return 'Giảng viên';
      case TeacherPosition.staff:
        return 'Nhân viên';
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
              _getPositionText(TeacherPosition.dean),
              TeacherPosition.dean,
            ),
            const SizedBox(width: 8),
            _buildFilterButton(
              _getPositionText(TeacherPosition.viceDean),
              TeacherPosition.viceDean,
            ),
            const SizedBox(width: 8),
            _buildFilterButton(
              _getPositionText(TeacherPosition.lecturer),
              TeacherPosition.lecturer,
            ),
            const SizedBox(width: 8),
            _buildFilterButton(
              _getPositionText(TeacherPosition.staff),
              TeacherPosition.staff,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, TeacherPosition? position) {
    final bool isSelected = currentFilter == position;
    return CustomButton(
      text: text,
      onPressed: () => onFilterChanged(position),
      backgroundColor: isSelected ? Colors.blueAccent : Colors.grey.shade300,
      textColor: isSelected ? Colors.white : Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
