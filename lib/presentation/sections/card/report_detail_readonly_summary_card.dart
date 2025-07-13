import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_bien_bang_shcn.dart';
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';
import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart' hide HoSo;

class ReportDetailReadonlySummaryCard extends StatelessWidget {
  final int selectedWeek;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String selectedRoom;
  final int total;
  final int present;
  final int absent;
  final String content;
  final String teacherName;
  final String secretaryName;
  final List<ChiTietBienBan> chiTietBienBanList;
  final List<int> absentStudentIds;
  final List<StudentWithRole> studentList;
  final Map<int, String> absenceReasons;

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
    required this.secretaryName,
    required this.teacherName,
    required this.chiTietBienBanList,
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
                'Thời gian bắt đầu sinh hoạt lớp: ${DateFormat('HH:mm').format(selectedDate)}, ngày ${DateFormat('dd').format(selectedDate)} tháng ${DateFormat('MM').format(selectedDate)} năm ${DateFormat('yyyy').format(selectedDate)}',
              ),

              Text('Địa điểm sinh hoạt: Trường Cao Đẳng Kỹ Thuật Cao Thắng'),
              const SizedBox(height: 8),

              const Text(
                'Thành phần tham dự gồm có:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(' - Giáo viên chủ nhiệm (ghi họ và tên): $teacherName'),
              Text(' - Thư ký (ghi họ và tên): $secretaryName'),
              Text(
                ' - Sĩ số: $total       Hiện diện: $present        Vắng mặt: $absent',
              ),

              if (absentStudentIds.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text('Họ và tên HSSV vắng, lý do:'),
                ...absentStudentIds.map((id) {
                  final ctbb = chiTietBienBanList.firstWhere(
                    (e) => e.sinhVien.id == id,
                    orElse: () => ChiTietBienBan(
                      id: -1,
                      idBienBanShcn: -1,
                      lyDo: '',
                      loai: 0,
                      sinhVien: SinhVien(
                        id: id,
                        maSv: '',
                        hoSo: HoSo.empty(),
                        trangThai: 0,
                        lop: Lop.empty(),
                        diemRenLuyens: [],
                      ),
                    ),
                  );

                  final reason =
                      absenceReasons[id] ?? ctbb.lyDo ?? 'Không rõ lý do';
                  final isExcused = ctbb.loai == 1;

                  return Text(
                    '  ${ctbb.sinhVien.hoSo.hoTen}, Lý do: $reason (${isExcused ? "Có phép" : "Không phép"})',
                  );
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
                children: [
                  SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('GVCN (Ký, ghi rõ họ tên)'),
                        const SizedBox(height: 48),
                        Text(teacherName),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Thư ký (Ký, ghi rõ họ tên)'),
                        const SizedBox(height: 48),
                        Text(secretaryName),
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
