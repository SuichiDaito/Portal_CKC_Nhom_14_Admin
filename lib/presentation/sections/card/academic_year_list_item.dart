import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/presentation/pages/page_academic_year_management.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class AcademicYearListItem extends StatelessWidget {
  final AcademicYear academicYear;
  final Function(DateTime) onInitialize; // ✅ Đổi kiểu callback để truyền ngày

  const AcademicYearListItem({
    Key? key,
    required this.academicYear,
    required this.onInitialize,
  }) : super(key: key);

  String _getTermText(AcademicTerm term) {
    switch (term) {
      case AcademicTerm.term1:
        return 'Học kỳ 1';
      case AcademicTerm.term2:
        return 'Học kỳ 2';
      case AcademicTerm.summerTerm:
        return 'Học kỳ hè';
    }
  }

  Color _getStatusColor(AcademicYearStatus status) {
    switch (status) {
      case AcademicYearStatus.initialized:
        return Colors.green;
      case AcademicYearStatus.notInitialized:
        return Colors.orange;
    }
  }

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
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Niên khóa: ${academicYear.cohort}',
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Học kỳ: ${_getTermText(academicYear.term)} - Năm: ${academicYear.year}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ngày bắt đầu: ${academicYear.startDate != null ? DateFormat('dd/MM/yyyy').format(academicYear.startDate!) : 'Chưa có'}',
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Trạng thái:',
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      academicYear.status,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: _getStatusColor(academicYear.status),
                    ),
                  ),
                  child: Text(
                    _getStatusText(academicYear.status),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(academicYear.status),
                    ),
                  ),
                ),
              ],
            ),
            if (academicYear.status == AcademicYearStatus.notInitialized)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    text: 'Khởi tạo',
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        helpText: 'Chọn ngày bắt đầu học kỳ',
                      );

                      if (selectedDate != null) {
                        onInitialize(selectedDate); // ✅ Gửi ngày về parent
                      }
                    },
                    backgroundColor: Colors.blue.shade600,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
