import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportDetailReadonlySummaryCard extends StatelessWidget {
  final int selectedWeek;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String selectedRoom;
  final int total;
  final int present;
  final int absent;
  final String content;
  final List<String> absentStudentIds;
  final List<Map<String, String>> studentList;
  final Map<String, String> absenceReasons;

  const ReportDetailReadonlySummaryCard({
    super.key,
    required this.selectedWeek,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedRoom,
    required this.total,
    required this.present,
    required this.absent,
    required this.content,
    required this.absentStudentIds,
    required this.studentList,
    required this.absenceReasons,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime endDate = selectedDate.add(const Duration(days: 7));

    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      'TRƯỜNG CĐ KỸ THUẬT CAO THẮNG',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'PHÒNG CÔNG TÁC CHÍNH TRỊ-HSSV',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text('Độc lập - Tự do - Hạnh phúc'),
                    const Text('*****'),
                    const SizedBox(height: 16),
                    const Text(
                      'BIÊN BẢN SINH HOẠT CHỦ NHIỆM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'TUẦN THỨ: $selectedWeek (${DateFormat('dd/MM/yyyy').format(selectedDate)} – ${DateFormat('dd/MM/yyyy').format(endDate)})',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Thời gian bắt đầu sinh hoạt lớp: ${selectedTime.format(context)}, ngày ${DateFormat('dd').format(selectedDate)} tháng ${DateFormat('MM').format(selectedDate)} năm ${DateFormat('yyyy').format(selectedDate)}',
              ),
              Text('Địa điểm sinh hoạt: $selectedRoom'),
              const SizedBox(height: 8),

              const Text(
                'Thành phần tham dự gồm có:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Text(
                ' - Giáo viên chủ nhiệm (ghi họ và tên): Nguyễn Đức Duy',
              ),
              const Text(' - Thư ký (ghi họ và tên): Tạ Kiều Ngân'),
              Text(
                ' - Sĩ số: $total       Hiện diện: $present        Vắng mặt: $absent',
              ),

              if (absentStudentIds.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text('Họ và tên HSSV vắng, lý do:'),
                ...absentStudentIds.map((mssv) {
                  final student = studentList.firstWhere(
                    (s) => s['mssv'] == mssv,
                    orElse: () => {'mssv': mssv, 'name': 'Không rõ'},
                  );
                  final reason = absenceReasons[mssv] ?? 'Không rõ lý do';
                  return Text('  ${student['name']}, Lý do: $reason');
                }).toList(),
              ],

              const SizedBox(height: 16),
              const Text(
                'NỘI DUNG (Ghi tóm tắt nội dung sinh hoạt):',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(content),

              const SizedBox(height: 16),
              const Text(
                'CÁC ĐỀ XUẤT, KIẾN NGHỊ:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Text(
                '..........................................................................................',
              ),
              const Text(
                '..........................................................................................',
              ),

              const SizedBox(height: 16),
              Text(
                'Buổi sinh hoạt kết thúc lúc: ${selectedTime.replacing(hour: selectedTime.hour + 1).format(context)} cùng ngày.',
              ),

              const SizedBox(height: 24),
              Wrap(
                spacing: 24,
                runSpacing: 16,
                alignment: WrapAlignment.spaceBetween,
                children: const [
                  SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('GVCN (Ký, ghi rõ họ tên)'),
                        SizedBox(height: 48),
                        Text('Nguyễn Đức Duy'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Thư ký (Ký, ghi rõ họ tên)'),
                        SizedBox(height: 48),
                        Text('Tạ Kiều Ngân'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
