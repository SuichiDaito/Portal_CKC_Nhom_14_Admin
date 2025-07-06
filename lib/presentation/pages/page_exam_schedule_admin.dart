import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lich_thi.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lich_thi_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/event/lich_thi_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/bloc/state/lich_thi_state.dart';
import 'package:portal_ckc/presentation/sections/card/class_management_teacher_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/exam_schedule_view.dart';
import 'package:portal_ckc/presentation/sections/card/show_dialog_print_exam.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_print_schedule_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageExamScheduleAdmin extends StatefulWidget {
  @override
  _PageExamScheduleAdminState createState() => _PageExamScheduleAdminState();
}

class _PageExamScheduleAdminState extends State<PageExamScheduleAdmin> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _fetchAdminInfo();
    _fetchExamScheduleByTeacher();
  }

  Future<void> _fetchExamScheduleByTeacher() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId != null) {
      context.read<LichThiBloc>().add(FetchLichThiByGiangVienId(userId));
    }
  }

  Future<void> _fetchAdminInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId != null) {
      context.read<AdminBloc>().add(FetchAdminDetail(userId));
    } else {
      print('⚠️ Không tìm thấy user_id trong SharedPreferences');
    }
  }

  void _showPrintDialog() {
    showDialog(
      context: context,
      builder: (_) => PrintExamDialog(
        initialFromDate: DateTime.now(),
        initialToDate: DateTime.now(),
        onPrint: (from, to) {
          print('In từ ${from.toIso8601String()} đến ${to.toIso8601String()}');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quản lý Lịch Gác Thi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,

        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: _showPrintDialog,
            tooltip: 'In lịch gác thi',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E517B), Color(0xFF384CD0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is AdminLoaded || state is AdminSuccess) {
                  final user = state is AdminLoaded
                      ? state.user
                      : (state as AdminSuccess).user;
                  return TeacherInfoCard(
                    teacherName: user.hoSo?.hoTen ?? 'Không rõ',
                    teacherId: '${user.id}',
                    department:
                        user.boMon?.nganhHoc?.khoa?.tenKhoa ??
                        'Chưa có thông tin',
                  );
                } else if (state is AdminLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return TeacherInfoCard(
                    teacherName: 'Không rõ',
                    teacherId: '---',
                    department: '---',
                  );
                }
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 8,
                children: ['Tất cả', 'Chưa diễn ra', 'Đã hoàn thành']
                    .map(
                      (status) => ChoiceChip(
                        label: Text(status),
                        selected: (selectedStatus ?? 'Tất cả') == status,
                        selectedColor: Colors.blue,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: (selectedStatus ?? 'Tất cả') == status
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (_) {
                          setState(() {
                            selectedStatus = status == 'Tất cả' ? null : status;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: BlocBuilder<LichThiBloc, LichThiState>(
                builder: (context, state) {
                  if (state is LichThiLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LichThiLoaded) {
                    if (state.lichThiList.isEmpty) {
                      return Center(
                        child: Text('Không có lịch thi được phân công'),
                      );
                    }
                    final now = DateTime.now();
                    final filteredList = state.lichThiList.where((lich) {
                      final ngayThi = DateTime.tryParse(lich.ngayThi);
                      if (ngayThi == null) return false;

                      if (selectedStatus == null || selectedStatus == 'Tất cả')
                        return true;

                      if (selectedStatus == 'Chưa diễn ra') {
                        return ngayThi.isAfter(
                          DateTime(now.year, now.month, now.day),
                        );
                      } else if (selectedStatus == 'Đã hoàn thành') {
                        return ngayThi.isBefore(
                          DateTime(now.year, now.month, now.day),
                        );
                      } else if (selectedStatus == 'Đang diễn ra') {
                        return ngayThi.year == now.year &&
                            ngayThi.month == now.month &&
                            ngayThi.day == now.day;
                      }

                      return true;
                    }).toList();
                    final Map<String, List<ExamSchedule>> grouped = {};
                    for (final lich in filteredList) {
                      final key = lich.ngayThi;
                      if (!grouped.containsKey(key)) grouped[key] = [];
                      grouped[key]!.add(lich);
                    }

                    return ExamScheduleView(
                      selectedDay: null,
                      scheduleData: grouped,
                      onDayTap: (day) {},
                    );
                  } else if (state is LichThiError) {
                    return Center(child: Text(state.message));
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
