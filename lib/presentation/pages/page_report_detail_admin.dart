import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_bien_bang_shcn.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bien_bang_shcn_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/event/bien_bang_shcn_event.dart';
import 'package:portal_ckc/bloc/event/tuan_event.dart';
import 'package:portal_ckc/bloc/state/bien_bang_shcn_state.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/presentation/sections/dialogs/approve_bien_ban_dialog.dart';
import 'package:portal_ckc/presentation/sections/report_detail_pending_view.dart';

class PageReportDetailAdmin extends StatefulWidget {
  final BienBanSHCN bienBan;

  const PageReportDetailAdmin({super.key, required this.bienBan});

  @override
  State<PageReportDetailAdmin> createState() => _PageReportDetailAdminState();
}

class _PageReportDetailAdminState extends State<PageReportDetailAdmin> {
  bool isEditing = false;
  String selectedWeek = '1';
  DateTime selectedDate = DateTime.now();
  String selectedRoom = 'F7.1';
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
    context.read<BienBangShcnBloc>().add(FetchBienBanDetail(widget.bienBan.id));
    context.read<AdminBloc>().add(FetchStudentList(widget.bienBan.idLop));
    context.read<TuanBloc>().add(FetchTuanEvent(selectedDate.year));
  }

  void _showApproveDialog() {
    showDialog(
      context: context,
      builder: (_) => ApproveBienBanDialog(bienBanId: widget.bienBan.id),
    );
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
                FetchBienBanDetail(widget.bienBan.id),
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
                                  child: ReportDetailPendingView(
                                    studentList: studentList,
                                    bienBan: bienBan,
                                    isEditing: isEditing,
                                    canEdit: bienBan.trangThai == 1,
                                    absentStudentIds: absentStudentIds,
                                    absenceReasons: absenceReasons,
                                    isExcusedMap: isExcusedMap,
                                    selectedWeek: selectedWeek,
                                    selectedDate: selectedDate,
                                    selectedRoom: selectedRoom,
                                    selectedTime: selectedTime,
                                    content: content,
                                    weekOptions: weekOptions,
                                    rooms: rooms,
                                    onToggleEdit: () =>
                                        setState(() => isEditing = !isEditing),
                                    onApprove: _showApproveDialog,
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
                                      final chiTiet = matches.isNotEmpty
                                          ? matches.first
                                          : null;

                                      if (chiTiet != null) {
                                        context.read<BienBangShcnBloc>().add(
                                          DeleteSinhVienVangEvent(chiTiet.id),
                                        );
                                      }
                                    },
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
                                    onWeekChanged: (val) =>
                                        setState(() => selectedWeek = val),
                                    onDateChanged: (val) =>
                                        setState(() => selectedDate = val),
                                    onRoomChanged: (val) =>
                                        setState(() => selectedRoom = val),
                                    onTimeChanged: (val) =>
                                        setState(() => selectedTime = val),
                                    onContentChanged: (val) =>
                                        setState(() => content = val),
                                  ),
                                ),

                                if (isEditing && bienBan.trangThai == 1)
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (content.trim().isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Nội dung biên bản không được để trống!',
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }
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
                      return Center(child: Text(''));
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
}
