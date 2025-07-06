import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_bien_bang_shcn.dart';
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bien_bang_shcn_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/event/bien_bang_shcn_event.dart';
import 'package:portal_ckc/bloc/event/tuan_event.dart';
import 'package:portal_ckc/bloc/state/bien_bang_shcn_state.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_absent_student_manager.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_build_content_input.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_fixed_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_readonly_summary_card.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_editable_section.dart';

class PageReportDetailAdmin extends StatefulWidget {
  final int bienBanId;
  final int lopId;

  const PageReportDetailAdmin({
    super.key,
    required this.bienBanId,
    required this.lopId,
  });

  @override
  State<PageReportDetailAdmin> createState() => _PageReportDetailAdminState();
}

class _PageReportDetailAdminState extends State<PageReportDetailAdmin> {
  bool isEditing = false;
  String selectedWeek = '1';
  DateTime selectedDate = DateTime.now();
  String selectedRoom = 'P101';
  TimeOfDay selectedTime = TimeOfDay(hour: 7, minute: 0);
  String content = '';
  bool isInitialized = false;

  List<int> absentStudentIds = [];
  Map<int, String> absenceReasons = {};
  Map<int, bool> isExcusedMap = {};

  List<Map<String, dynamic>> weekOptions = [];
  List<String> rooms = [];

  @override
  void initState() {
    super.initState();
    context.read<BienBangShcnBloc>().add(FetchBienBanDetail(widget.bienBanId));
    context.read<AdminBloc>().add(FetchStudentList(widget.lopId));
    context.read<TuanBloc>().add(FetchTuanEvent(selectedDate.year));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, 'refresh');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chi tiết biên bản'),
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, 'refresh'),
          ),
        ),
        body: BlocListener<BienBangShcnBloc, BienBanState>(
          listener: (context, state) {
            if (state is BienBanActionSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
              context.read<BienBangShcnBloc>().add(
                FetchBienBanDetail(widget.bienBanId),
              );
              setState(() {
                isEditing = false;
                isInitialized = false;
              });
            }
            if (state is BienBanError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Lỗi: ${state.message}")));
            }
          },
          child: BlocBuilder<TuanBloc, TuanState>(
            builder: (context, tuanState) {
              if (tuanState is TuanLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (tuanState is TuanError) {
                return Center(child: Text('Lỗi tuần: ${tuanState.message}'));
              }
              if (tuanState is TuanLoaded) {
                weekOptions = tuanState.danhSachTuan.map((e) {
                  return {
                    'label': 'Tuần ${e.tuan}',
                    'value': e.tuan.toString(),
                  };
                }).toList();

                return BlocBuilder<BienBangShcnBloc, BienBanState>(
                  builder: (context, bienBanState) {
                    if (bienBanState is BienBanLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (bienBanState is BienBanDetailLoaded) {
                      final bienBan = bienBanState.bienBan;
                      return BlocBuilder<AdminBloc, AdminState>(
                        builder: (context, adminState) {
                          if (adminState is AdminLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (adminState is StudentListLoaded) {
                            final studentList = adminState.students;

                            if (!isInitialized) {
                              absentStudentIds = bienBan.chiTiet
                                  .map((e) => e.sinhVien.id)
                                  .toList();
                              absenceReasons = {
                                for (var e in bienBan.chiTiet)
                                  e.sinhVien.id: e.lyDo,
                              };
                              isExcusedMap = {
                                for (var e in bienBan.chiTiet)
                                  e.sinhVien.id: e.loai == 1,
                              };

                              selectedWeek = bienBan.tuan.tuan.toString();
                              selectedDate = bienBan.thoiGianBatDau;
                              selectedTime = TimeOfDay.fromDateTime(
                                bienBan.thoiGianBatDau,
                              );
                              selectedRoom = 'P101';
                              content = bienBan.noiDung;

                              isInitialized = true;
                            }

                            return Column(
                              children: [
                                Expanded(
                                  child: _buildPendingView(
                                    studentList,
                                    bienBan,
                                  ),
                                ),
                                if (isEditing && bienBan.trangThai == 0)
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        final data = {
                                          'id_sv': bienBan.thuky.id,
                                          'id_tuan':
                                              int.tryParse(selectedWeek) ??
                                              bienBan.tuan.id,

                                          'tieu_de':
                                              'Biên bản sinh hoạt chủ nhiệm',
                                          'noi_dung': content,
                                          'thoi_gian_bat_dau':
                                              "${selectedDate.toIso8601String().split('T')[0]}T${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
                                          'thoi_gian_ket_thuc':
                                              "${selectedDate.toIso8601String().split('T')[0]}T${(selectedTime.hour + 1).toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
                                          'so_luong_sinh_vien':
                                              studentList.length,
                                          'vang_mat': absentStudentIds.length,
                                          'sinh_vien_vang': {
                                            for (var id in absentStudentIds)
                                              id.toString(): {
                                                'ly_do':
                                                    absenceReasons[id] ?? '',
                                                'loai': isExcusedMap[id] == true
                                                    ? 1
                                                    : 0,
                                              },
                                          },
                                          'trang_thai': 0,
                                        };
                                        print(jsonEncode(data));
                                        context.read<BienBangShcnBloc>().add(
                                          UpdateBienBanEvent(
                                            bienBanId: bienBan.id,
                                            data: data,
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.save),
                                      label: const Text("Lưu biên bản"),
                                    ),
                                  ),
                              ],
                            );
                          }
                          return const Center(
                            child: Text('Không có dữ liệu sinh viên'),
                          );
                        },
                      );
                    }
                    if (bienBanState is BienBanError) {
                      return Center(
                        child: Text('Lỗi: ${bienBanState.message}'),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPendingView(
    List<StudentWithRole> studentList,
    BienBanSHCN bienBan,
  ) {
    final total = studentList.length;
    final absent = absentStudentIds.length;
    final present = total - absent;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportDetailFixedInfoCard(
            isEditing: isEditing,
            canEdit: (bienBan.trangThai ?? 0) == 0,
            onToggleEdit: () => setState(() => isEditing = !isEditing),
            onApprove: _showApproveDialog,
          ),

          const SizedBox(height: 12),
          if (isEditing && bienBan.trangThai == 0) ...[
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
                    onWeekChanged: (val) => setState(() => selectedWeek = val),
                    onDateChanged: (val) => setState(() => selectedDate = val),
                    onRoomChanged: (val) => setState(() => selectedRoom = val),
                    onTimeChanged: (val) => setState(() => selectedTime = val),
                  ),
                  const SizedBox(height: 12),
                  ReportDetailBuildContentInput(
                    content: content,
                    onChanged: (val) => setState(() => content = val),
                  ),
                  const SizedBox(height: 12),
                  AbsentStudentManager(
                    studentList: studentList,
                    absentStudentIds: absentStudentIds,
                    onAddAbsentStudent: (id) {
                      setState(() {
                        absentStudentIds.add(id);
                        absenceReasons[id] = '';
                        isExcusedMap[id] = false;
                      });
                    },
                    onRemoveAbsentStudent: (id) {
                      setState(() {
                        absentStudentIds.remove(id);
                        absenceReasons.remove(id);
                        isExcusedMap.remove(id);
                      });

                      final matches = bienBan.chiTiet
                          .where((e) => e.sinhVien.id == id)
                          .toList();
                      final chiTiet = matches.isNotEmpty ? matches.first : null;

                      if (chiTiet != null) {
                        context.read<BienBangShcnBloc>().add(
                          DeleteSinhVienVangEvent(chiTiet.id),
                        );
                      } else {
                        print('Không tìm thấy chiTietId cho sinh viên ID $id');
                      }
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
                      });
                    },
                  ),
                ],
              ),
            ),
          ] else
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
              secretaryName: '',
              teacherName: '',
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

  void _showApproveDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận duyệt biên bản'),
        content: const Text('Bạn có chắc muốn duyệt biên bản này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              context.read<BienBangShcnBloc>().add(
                ConfirmBienBan(widget.bienBanId),
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đang duyệt biên bản...")),
              );
            },
            child: const Text('Duyệt'),
          ),
        ],
      ),
    );
  }
}
