import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bien_bang_shcn_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/event/tuan_event.dart';
import 'package:portal_ckc/bloc/event/bien_bang_shcn_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/bloc/state/bien_bang_shcn_state.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/presentation/sections/button/custom_date_picker_row.dart';
import 'package:portal_ckc/presentation/sections/button/custom_dropdown_row.dart';
import 'package:portal_ckc/presentation/sections/button/custom_time_picker_row.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_absent_student_manager.dart';

class PageCreateMeetingMinutesAdmin extends StatefulWidget {
  final Lop lop;
  const PageCreateMeetingMinutesAdmin({super.key, required this.lop});

  @override
  State<PageCreateMeetingMinutesAdmin> createState() =>
      _PageCreateMeetingMinutesAdminState();
}

class _PageCreateMeetingMinutesAdminState
    extends State<PageCreateMeetingMinutesAdmin> {
  String selectedWeek = '1';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 7, minute: 0);
  String selectedRoom = 'P101';
  String content = '';
  List<String> weekLabels = [];
  List<StudentWithRole> studentList = [];
  List<int> absentStudentIds = [];
  Map<int, String> absenceReasons = {};
  Map<int, bool> isExcusedMap = {};

  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TuanBloc>().add(FetchTuanEvent(DateTime.now().year));
    context.read<AdminBloc>().add(FetchStudentList(widget.lop.id));
  }

  void _submitBienBan() {
    if (contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập nội dung biên bản.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final thoiGianBatDau = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final thoiGianKetThuc = thoiGianBatDau.add(const Duration(hours: 1));

    final data = {
      'id_sv': widget.lop.idGvcn,
      'id_tuan': int.parse(selectedWeek),
      'tieu_de': 'Biên bản sinh hoạt chủ nhiệm',
      'noi_dung': contentController.text,
      'thoi_gian_bat_dau': DateFormat(
        "yyyy-MM-dd'T'HH:mm",
      ).format(thoiGianBatDau),
      'thoi_gian_ket_thuc': DateFormat(
        "yyyy-MM-dd'T'HH:mm",
      ).format(thoiGianKetThuc),
      'so_luong_sinh_vien': studentList.length,
      'vang_mat': absentStudentIds.length,
      'sinh_vien_vang': {
        for (var id in absentStudentIds)
          '$id': {
            'ly_do': absenceReasons[id] ?? '',
            'co_phep': isExcusedMap[id] ?? false,
          },
      },
    };

    context.read<BienBangShcnBloc>().add(
      CreateBienBanEvent(lopId: widget.lop.id, data: data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BienBangShcnBloc, BienBanState>(
      listener: (context, state) {
        if (state is BienBanActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tạo biên bản thành công')),
          );
          Navigator.pop(context, 'refresh');
        }

        if (state is BienBanError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Không thể tạo biên bản sinh hoạt chủ nhiệm! Vui lòng thử lại',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tạo biên bản sinh hoạt'),
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<TuanBloc, TuanState>(
          builder: (context, tuanState) {
            if (tuanState is TuanLoaded) {
              weekLabels = tuanState.danhSachTuan
                  .map((t) => 'Tuần ${t.tuan}')
                  .toList();

              return BlocBuilder<AdminBloc, AdminState>(
                builder: (context, adminState) {
                  if (adminState is StudentListLoaded) {
                    if (studentList.isEmpty) {
                      studentList = adminState.students;
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [_buildLopInfoCard(), _buildFormCard()],
                        ),
                      ),
                    );
                  }

                  if (adminState is AdminLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (adminState is AdminError) {
                    return Center(
                      child: Text(
                        'Lỗi khi tải sinh viên: ${adminState.message}',
                      ),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildLopInfoCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1976D2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'THÔNG TIN LỚP',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(color: Colors.white),
          const SizedBox(height: 8),
          Text(
            'Lớp: ${widget.lop.tenLop}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Niên khóa: ${widget.lop.nienKhoa.tenNienKhoa ?? 'Chưa cập nhật'}',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Sĩ số: ${widget.lop.siSo ?? 'Chưa cập nhật'}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdownRow(
              label: "Tuần",
              value: 'Tuần $selectedWeek',
              items: weekLabels,
              onChanged: (val) {
                if (val != null) {
                  setState(
                    () => selectedWeek = val.replaceAll(RegExp(r'\D'), ''),
                  );
                }
              },
            ),
            const SizedBox(height: 12),
            CustomDatePickerRow(
              label: "Ngày",
              date: selectedDate,
              onPicked: (picked) {
                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
            ),
            const SizedBox(height: 12),
            CustomTimePickerRow(
              label: "Giờ",
              time: selectedTime,
              onPicked: (picked) {
                if (picked != null) {
                  setState(() => selectedTime = picked);
                }
              },
            ),

            AbsentStudentManager(
              studentList: studentList,
              absentStudentIds: absentStudentIds,
              onAddAbsentStudent: (id) {
                setState(() => absentStudentIds.add(id));
              },
              onRemoveAbsentStudent: (id) {
                setState(() {
                  absentStudentIds.remove(id);
                  absenceReasons.remove(id);
                  isExcusedMap.remove(id);
                });
              },
              absenceReasons: absenceReasons,
              isExcusedMap: isExcusedMap,
              onReasonChanged: (id, reason) {
                setState(() {
                  absenceReasons[id] = reason;
                });
              },
              onExcusedChanged: (id, isExcused) {
                setState(() {
                  isExcusedMap[id] = isExcused;
                  print('✔️ ID $id có phép: $isExcused');
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              minLines: 5,
              maxLines: 20,
              decoration: const InputDecoration(
                labelText: 'Nội dung',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => content = val,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _submitBienBan,
              icon: const Icon(Icons.save),
              label: const Text("Tạo biên bản"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
