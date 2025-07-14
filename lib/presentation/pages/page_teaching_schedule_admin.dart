import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_phieu_len_lop.dart';
import 'package:portal_ckc/api/model/admin_tuan.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/event/nienkhoa_hocky_event.dart';
import 'package:portal_ckc/bloc/event/tuan_event.dart';
import 'package:portal_ckc/bloc/state/lop_hoc_phan_state.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_day_selector.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_print_schedule_dialog.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_view.dart';

class Subject {
  final String name;
  final String className;
  final String type;
  final String room;
  final String period;

  Subject(this.name, this.className, this.type, this.room, this.period);
}

class PageTeachingScheduleAdmin extends StatefulWidget {
  @override
  _PageTeachingScheduleAdminState createState() =>
      _PageTeachingScheduleAdminState();
}

class _PageTeachingScheduleAdminState extends State<PageTeachingScheduleAdmin> {
  int selectedWeek = 1;
  String? selectedDay;

  List<TuanModel> _tuanList = [];

  List<DropdownItem> _weeks = [];
  DropdownItem? _selectedWeek;
  Map<String, Map<String, List<Subject>>> convertToScheduleData(
    List<LopHocPhan> list,
    int selectedWeekId,
  ) {
    final Map<String, Map<String, List<Subject>>> result = {
      'Thứ 2': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 3': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 4': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 5': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 6': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 7': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Chủ nhật': {'Sáng': [], 'Chiều': [], 'Tối': []},
    };

    for (final lhp in list) {
      for (final tkb in lhp.thoiKhoaBieu ?? []) {
        if (tkb.idTuan != selectedWeekId) continue;

        final DateTime ngay =
            DateTime.tryParse(tkb.ngay ?? '') ?? DateTime.now();
        final String thu = _convertWeekdayToVietnamese(ngay.weekday);
        final int tietBatDau = tkb.tietBatDau ?? 0;

        String buoi = 'Sáng';
        if (tietBatDau >= 7 && tietBatDau <= 12) {
          buoi = 'Chiều';
        } else if (tietBatDau > 12) {
          buoi = 'Tối';
        }

        final subject = Subject(
          lhp.tenHocPhan ?? '',
          lhp.lop?.tenLop ?? '',
          lhp.loaiMon == 0
              ? 'Đại cương'
              : (lhp.loaiMon == 1 ? 'Cơ sở' : 'Chuyên ngành'),
          tkb.phong?.ten ?? '',
          '${tkb.tietBatDau}-${tkb.tietKetThuc}',
        );

        result[thu]?[buoi]?.add(subject);
      }
    }

    result.removeWhere((thu, buoiMap) {
      final totalSubjects = buoiMap.values.fold<int>(
        0,
        (sum, subjects) => sum + subjects.length,
      );
      return totalSubjects == 0;
    });

    return result;
  }

  String _convertWeekdayToVietnamese(int weekday) {
    switch (weekday) {
      case 1:
        return 'Thứ 2';
      case 2:
        return 'Thứ 3';
      case 3:
        return 'Thứ 4';
      case 4:
        return 'Thứ 5';
      case 5:
        return 'Thứ 6';
      case 6:
        return 'Thứ 7';
      case 7:
        return 'Chủ nhật';
      default:
        return '';
    }
  }

  void _printSchedule(int fromWeek, int toWeek) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('In TKB từ tuần $fromWeek đến tuần $toWeek')),
    );
  }

  void _showPrintDialog() {
    final selectedWeekId = int.tryParse(_selectedWeek?.value ?? '') ?? 1;

    showDialog(
      context: context,
      builder: (_) => PrintScheduleDialog(
        fromWeek: selectedWeekId,
        toWeek: selectedWeekId,
        tuanList: _tuanList,
        onPrint: _printSchedule,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TuanBloc>().add(FetchTuanEvent(2025));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quản lý Thời Khóa Biểu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (selectedDay != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  selectedDay = null;
                });
              },
              tooltip: 'Hiển thị tất cả',
            ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () => _showPrintDialog(),
            tooltip: 'In thời khóa biểu',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 30, 81, 123),
              Color.fromARGB(255, 56, 76, 208),
            ],
          ),
        ),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lọc theo Tuần',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<TuanBloc, TuanState>(
                      builder: (context, tuanState) {
                        if (tuanState is TuanLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (tuanState is TuanLoaded) {
                          _tuanList = tuanState.danhSachTuan;

                          _weeks = tuanState.danhSachTuan.map((tuan) {
                            return DropdownItem(
                              value: tuan.id.toString(),
                              label: 'Tuần ${tuan.tuan}',
                              icon: Icons.calendar_today,
                            );
                          }).toList();

                          if (_selectedWeek == null) {
                            final today = DateTime.now();

                            final matchingWeek = tuanState.danhSachTuan
                                .firstWhere((tuan) {
                                  final fromDate = DateTime.tryParse(
                                    tuan.ngayBatDau?.toString() ?? '',
                                  );
                                  final toDate = DateTime.tryParse(
                                    tuan.ngayKetThuc?.toString() ?? '',
                                  );

                                  if (fromDate == null || toDate == null)
                                    return false;
                                  return today.isAfter(
                                        fromDate.subtract(
                                          const Duration(days: 1),
                                        ),
                                      ) &&
                                      today.isBefore(
                                        toDate.add(const Duration(days: 1)),
                                      );
                                }, orElse: () => tuanState.danhSachTuan.first);

                            _selectedWeek = DropdownItem(
                              value: matchingWeek.id.toString(),
                              label: 'Tuần ${matchingWeek.tuan}',
                              icon: Icons.calendar_today,
                            );

                            selectedWeek =
                                int.tryParse(_selectedWeek?.value ?? '') ?? 1;
                            context.read<LopHocPhanBloc>().add(
                              FetchLopHocPhanTheoGiangVien(),
                            );
                          }

                          return DropdownSelector(
                            label: 'Tuần',
                            selectedItem: _selectedWeek,
                            items: _weeks,
                            onChanged: (item) {
                              setState(() {
                                _selectedWeek = item;
                                selectedWeek =
                                    int.tryParse(item?.value ?? '') ?? 1;
                              });

                              context.read<LopHocPhanBloc>().add(
                                FetchLopHocPhanTheoGiangVien(),
                              );
                            },
                          );
                        }
                        if (tuanState is TuanError) {
                          return const Text(
                            'Không thể truy cập chức năng này, vui lòng thử lại sau.',
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),

            DaySelector(
              selectedDay: selectedDay,
              onDayTap: (String day) {
                setState(() {
                  selectedDay = day;
                });
              },
            ),

            Expanded(
              child: BlocBuilder<LopHocPhanBloc, LopHocPhanState>(
                builder: (context, state) {
                  if (state is LopHocPhanLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LopHocPhanLoaded) {
                    final selectedWeekId =
                        int.tryParse(_selectedWeek?.value ?? '') ?? 1;

                    final dynamicData = convertToScheduleData(
                      state.lopHocPhans,
                      selectedWeekId,
                    );

                    return ScheduleView(
                      selectedWeek: selectedWeekId,
                      selectedDay: selectedDay,
                      scheduleData: dynamicData,
                      onDayTap: (String day) {
                        setState(() {
                          selectedDay = day;
                        });
                      },
                    );
                  } else if (state is LopHocPhanError) {
                    return Center(child: Text('Lỗi: ${state.message}'));
                  }
                  return const Center(child: Text('Không có dữ liệu'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
