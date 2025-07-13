import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_bien_bang_shcn.dart';
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bien_bang_shcn_bloc.dart';
import 'package:portal_ckc/bloc/state/bien_bang_shcn_state.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_absent_student_manager.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_build_content_input.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_editable_section.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_fixed_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_readonly_summary_card.dart';

class ReportDetailPendingView extends StatelessWidget {
  final List<StudentWithRole> studentList;
  final BienBanSHCN bienBan;
  final bool isEditing;
  final bool canEdit;
  final List<int> absentStudentIds;
  final Map<int, String> absenceReasons;
  final Map<int, bool> isExcusedMap;
  final String selectedWeek;
  final DateTime selectedDate;
  final String selectedRoom;
  final TimeOfDay selectedTime;
  final String content;
  final List<Map<String, dynamic>> weekOptions;
  final List<String> rooms;
  final void Function() onToggleEdit;
  final void Function() onApprove;
  final void Function(int) onAddAbsentStudent;
  final void Function(int) onRemoveAbsentStudent;
  final void Function(int, String) onReasonChanged;
  final void Function(int, bool) onExcusedChanged;
  final void Function(String) onWeekChanged;
  final void Function(DateTime) onDateChanged;
  final void Function(String) onRoomChanged;
  final void Function(TimeOfDay) onTimeChanged;
  final void Function(String) onContentChanged;

  const ReportDetailPendingView({
    super.key,
    required this.studentList,
    required this.bienBan,
    required this.isEditing,
    required this.canEdit,
    required this.absentStudentIds,
    required this.absenceReasons,
    required this.isExcusedMap,
    required this.selectedWeek,
    required this.selectedDate,
    required this.selectedRoom,
    required this.selectedTime,
    required this.content,
    required this.weekOptions,
    required this.rooms,
    required this.onToggleEdit,
    required this.onApprove,
    required this.onAddAbsentStudent,
    required this.onRemoveAbsentStudent,
    required this.onReasonChanged,
    required this.onExcusedChanged,
    required this.onWeekChanged,
    required this.onDateChanged,
    required this.onRoomChanged,
    required this.onTimeChanged,
    required this.onContentChanged,
  });

  @override
  Widget build(BuildContext context) {
    final total = studentList.length;
    final absent = absentStudentIds.length;
    final present = total - absent;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportDetailFixedInfoCard(
            bienBan: bienBan,
            isEditing: isEditing,
            canEdit: canEdit,
            onToggleEdit: onToggleEdit,
            onApprove: onApprove,
          ),
          const SizedBox(height: 12),
          if (isEditing && bienBan.trangThai == 1)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "BIÊN BẢNG SINH HOẠT CHỦ NHIỆM",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ReportDetailEditableSection(
                    selectedWeek: selectedWeek,
                    selectedDate: selectedDate,
                    selectedRoom: selectedRoom,
                    selectedTime: selectedTime,
                    weeks: weekOptions
                        .map((e) => e['value']! as String)
                        .toList(),
                    rooms: rooms,
                    onWeekChanged: onWeekChanged,
                    onDateChanged: onDateChanged,
                    onRoomChanged: onRoomChanged,
                    onTimeChanged: onTimeChanged,
                  ),
                  const SizedBox(height: 12),
                  ReportDetailBuildContentInput(
                    content: content,
                    onChanged: onContentChanged,
                  ),
                  const SizedBox(height: 12),
                  AbsentStudentManager(
                    studentList: studentList,
                    absentStudentIds: absentStudentIds,
                    onAddAbsentStudent: onAddAbsentStudent,
                    onRemoveAbsentStudent: onRemoveAbsentStudent,
                    absenceReasons: absenceReasons,
                    isExcusedMap: isExcusedMap,
                    onReasonChanged: onReasonChanged,
                    onExcusedChanged: onExcusedChanged,
                  ),
                ],
              ),
            )
          else
            ReportDetailReadonlySummaryCard(
              selectedWeek: int.tryParse(selectedWeek) ?? 0,
              selectedDate: selectedDate,
              selectedTime: selectedTime,
              selectedRoom: selectedRoom,
              total: total,
              present: present,
              absent: absent,
              content: content,
              absentStudentIds: absentStudentIds,
              studentList: studentList,
              absenceReasons: absenceReasons,
              secretaryName: bienBan.thuky.hoSo.hoTen,
              teacherName: bienBan.gvcn.hoSo!.hoTen ?? "",
              chiTietBienBanList:
                  context.read<BienBangShcnBloc>().state is BienBanDetailLoaded
                  ? (context.read<BienBangShcnBloc>().state
                            as BienBanDetailLoaded)
                        .bienBan
                        .chiTiet
                  : [],
            ),
        ],
      ),
    );
  }
}
