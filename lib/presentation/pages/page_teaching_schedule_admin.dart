import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
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
  List<DropdownItem> _schoolYears = [];
  DropdownItem? _selectedSchoolYear;
  bool _isSchoolYearLoaded = false;

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
        for (final lhp in list) {
          for (final tkb in lhp.thoiKhoaBieu ?? []) {
            print('tkb.idTuan: ${tkb.idTuan}, selectedWeekId: $selectedWeekId');
          }
        }

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

  //Xử lý chức năng in tkb
  void _printSchedule(int fromWeek, int toWeek) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('In TKB từ tuần $fromWeek đến tuần $toWeek')),
    );
  }

  void _showPrintDialog() {
    showDialog(
      context: context,
      builder: (_) => PrintScheduleDialog(
        fromWeek: selectedWeek,
        toWeek: selectedWeek,
        onPrint: _printSchedule,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<LopHocPhanBloc>().add(FetchLopHocPhanTheoGiangVien());
    context.read<NienKhoaHocKyBloc>().add(FetchNienKhoaHocKy());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quản lý Thời Khóa Biểu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (selectedDay != null)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  selectedDay = null;
                });
              },
              tooltip: 'Hiển thị tất cả',
            ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _showPrintDialog(),
            tooltip: 'In thời khóa biểu',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 30, 81, 123),
              const Color.fromARGB(255, 56, 76, 208),
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
                    Text(
                      'Lọc theo Niên khóa & Tuần',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child:
                              BlocBuilder<
                                NienKhoaHocKyBloc,
                                NienKhoaHocKyState
                              >(
                                builder: (context, state) {
                                  if (state is NienKhoaHocKyLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is NienKhoaHocKyLoaded) {
                                    if (!_isSchoolYearLoaded) {
                                      _schoolYears = state.nienKhoas.map((nk) {
                                        final name =
                                            '${nk.namBatDau}-${nk.namKetThuc}';
                                        return DropdownItem(
                                          value: nk.namBatDau,
                                          label: nk.tenNienKhoa,
                                          icon: Icons.school,
                                        );
                                      }).toList();
                                      _selectedSchoolYear =
                                          _schoolYears.isNotEmpty
                                          ? _schoolYears.first
                                          : null;
                                      _isSchoolYearLoaded = true;

                                      final namBatDau = int.tryParse(
                                        _selectedSchoolYear?.label
                                                .split('-')
                                                .first ??
                                            '',
                                      );
                                      if (namBatDau != null) {
                                        context.read<TuanBloc>().add(
                                          FetchTuanEvent(namBatDau),
                                        );
                                      }
                                    }

                                    return DropdownSelector(
                                      label: 'Niên khóa',
                                      selectedItem: _selectedSchoolYear,
                                      items: _schoolYears,
                                      onChanged: (item) {
                                        setState(() {
                                          _selectedSchoolYear = item;
                                        });

                                        final namBatDau = int.tryParse(
                                          item?.label.split('-').first ?? '',
                                        );
                                        if (namBatDau != null) {
                                          context.read<TuanBloc>().add(
                                            FetchTuanEvent(namBatDau),
                                          );
                                        }
                                      },
                                    );
                                  }
                                  if (state is NienKhoaHocKyError) {
                                    return Text(
                                      'Lỗi tải niên khóa: ${state.message}',
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BlocBuilder<TuanBloc, TuanState>(
                            builder: (context, tuanState) {
                              if (tuanState is TuanLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (tuanState is TuanLoaded) {
                                _weeks = tuanState.danhSachTuan.map((tuan) {
                                  return DropdownItem(
                                    value: tuan.id.toString(),
                                    label: 'Tuần ${tuan.tuan}',
                                    icon: Icons.calendar_today,
                                  );
                                }).toList();

                                _selectedWeek ??= _weeks.first;

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
                                return Text('Lỗi: ${tuanState.message}');
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ],
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
                    return Center(child: CircularProgressIndicator());
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
                  return Center(child: Text('Không có dữ liệu'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
