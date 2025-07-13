import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_lich_thi.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/presentation/sections/button/build_date_field.dart';
import 'package:portal_ckc/presentation/sections/button/build_time_field.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/button/info_row_dropdown_button.dart';
import 'package:portal_ckc/presentation/sections/card/exam_schedule_card.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';

class ExamScheduleGroupCard extends StatefulWidget {
  final String className;
  final String subjectName;
  final List<ExamSchedule> schedules;
  final List<DropdownItem> lecturers;
  final List<DropdownItem> rooms;
  final ValueChanged<ExamSchedule> onSave;
  final LopHocPhan lopHocPhan;

  const ExamScheduleGroupCard({
    Key? key,
    required this.className,
    required this.subjectName,
    required this.schedules,
    required this.lecturers,
    required this.lopHocPhan,
    required this.rooms,
    required this.onSave,
  }) : super(key: key);

  @override
  State<ExamScheduleGroupCard> createState() => _ExamScheduleGroupCardState();
}

class _ExamScheduleGroupCardState extends State<ExamScheduleGroupCard> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50, // Nền xanh nhạt
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.event_note, // Icon lịch thi
                color: Colors.blue, // Icon xanh
              ),
              title: Text(
                '${widget.className} - ${widget.subjectName}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Chữ xanh
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.blue,
                ),
                onPressed: () => setState(() => _isExpanded = !_isExpanded),
              ),
            ),
          ),
          if (_isExpanded)
            Column(
              children: [
                ...widget.schedules.map((schedule) {
                  final existingAttempts = widget.schedules
                      .where((e) => e.id != schedule.id)
                      .map((e) => e.lanThi)
                      .toList();

                  return ExamScheduleCard(
                    schedule: schedule,
                    onSave: widget.onSave,
                    lecturers: widget.lecturers,
                    rooms: widget.rooms,
                    trangThaiNopDiem: schedule.lopHocPhan.trangThaiNopBangDiem,
                    isNew: schedule.id == 0,
                    existingAttempts: existingAttempts,
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CustomButton(
                    text: 'Tạo lịch thi mới',
                    onPressed: () {
                      final newSchedule = ExamSchedule(
                        id: 0,
                        idLopHocPhan: widget.lopHocPhan.id,
                        ngayThi: DateFormat(
                          'yyyy-MM-dd',
                        ).format(DateTime.now()),
                        gioBatDau: '08:00',
                        idGiamThi1: 0,
                        idGiamThi2: 0,
                        idPhongThi: 0,
                        lanThi: widget.schedules.length + 1,
                        thoiGianThi: 90,
                        trangThai: 0,
                        lopHocPhan: widget.lopHocPhan,
                        giamThi1: User.empty(),
                        giamThi2: User.empty(),
                        phong: null,
                      );

                      setState(() {
                        widget.schedules.add(newSchedule);
                      });
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
