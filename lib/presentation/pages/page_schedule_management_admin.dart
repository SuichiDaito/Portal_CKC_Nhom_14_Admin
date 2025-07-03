import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_thoi_khoa_bieu.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nganh_khoa_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phong_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thoi_khoa_bieu_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/event/nganh_khoa_event.dart';
import 'package:portal_ckc/bloc/event/nienkhoa_hocky_event.dart';
import 'package:portal_ckc/bloc/event/phong_event.dart';
import 'package:portal_ckc/bloc/event/thoi_khoa_bieu_event.dart';
import 'package:portal_ckc/bloc/event/tuan_event.dart';
import 'package:portal_ckc/bloc/event/user_event.dart';
import 'package:portal_ckc/bloc/state/lop_hoc_phan_state.dart';
import 'package:portal_ckc/bloc/state/nganh_khoa_state.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';
import 'package:portal_ckc/bloc/state/phong_state.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_class_info_display.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_copy_card.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_detail_editor.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_detail_model.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';
import 'package:collection/collection.dart';
import 'package:portal_ckc/presentation/sections/dialogs/copy_week_dialog.dart';

class PageScheduleManagementAdmin extends StatefulWidget {
  const PageScheduleManagementAdmin({Key? key}) : super(key: key);

  @override
  _PageScheduleManagementAdminState createState() =>
      _PageScheduleManagementAdminState();
}

class _PageScheduleManagementAdminState
    extends State<PageScheduleManagementAdmin> {
  List<DropdownItem> _schoolYears = [];
  DropdownItem? _selectedSchoolYear;
  bool _isSchoolYearLoaded = false;
  List<DropdownItem> _boMonList = [];
  DropdownItem? _selectedBoMon;
  List<User> _allUsers = [];
  List<DropdownItem> _lecturers = [];
  DropdownItem? _selectedLecturer;
  int selectedWeek = 1;
  int? _selectedSourceWeekId;
  int? _selectedTargetWeekId;

  List<DropdownItem> _weeks = [];
  DropdownItem? _selectedWeek;
  String getThuFromDate(DateTime date) {
    final weekdays = [
      'Chủ nhật',
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
    ];
    return weekdays[date.weekday % 7];
  }

  DateTime? getDateFromWeekAndDay(String thu, DateTime ngayBatDau) {
    final thuToIndex = {
      'Thứ 2': 0,
      'Thứ 3': 1,
      'Thứ 4': 2,
      'Thứ 5': 3,
      'Thứ 6': 4,
      'Thứ 7': 5,
      'Chủ nhật': 6,
    };

    final index = thuToIndex[thu];
    if (index == null) return null;

    return ngayBatDau.add(Duration(days: index));
  }

  @override
  void initState() {
    super.initState();
    context.read<NienKhoaHocKyBloc>().add(FetchNienKhoaHocKy());
    context.read<NganhKhoaBloc>().add(FetchBoMonEvent());
    context.read<UserBloc>().add(FetchUsersEvent());
    context.read<LopHocPhanBloc>().add(FetchALLLopHocPhan());
    context.read<PhongBloc>().add(FetchRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final nienKhoaState = context.watch<NienKhoaHocKyBloc>().state;
    final tuanState = context.watch<TuanBloc>().state;
    final nganhKhoaState = context.watch<NganhKhoaBloc>().state;
    final userState = context.watch<UserBloc>().state;
    final phongState = context.watch<PhongBloc>().state;
    final lhpState = context.watch<LopHocPhanBloc>().state;

    final isLoadingFilterData =
        nienKhoaState is NienKhoaHocKyLoading ||
        tuanState is TuanLoading ||
        nganhKhoaState is NganhKhoaLoading ||
        userState is UserLoading ||
        phongState is PhongLoading ||
        lhpState is LopHocPhanLoading;

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý lịch tuần'),
        backgroundColor: Colors.blueAccent,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoadingFilterData
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Colors.blue,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF1976D2,
                                  ).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.filter_alt,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Lọc thông tin',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
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
                                            _schoolYears = state.nienKhoas.map((
                                              nk,
                                            ) {
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
                                                item?.label.split('-').first ??
                                                    '',
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
                                      _weeks = tuanState.danhSachTuan.map((
                                        tuan,
                                      ) {
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
                                                int.tryParse(
                                                  item?.value ?? '',
                                                ) ??
                                                1;
                                          });

                                          context.read<LopHocPhanBloc>().add(
                                            FetchALLLopHocPhan(),
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
                          const SizedBox(height: 20),
                          BlocBuilder<NganhKhoaBloc, NganhKhoaState>(
                            builder: (context, state) {
                              if (state is NganhKhoaLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is BoMonLoaded) {
                                _boMonList = state.boMons.map((bm) {
                                  return DropdownItem(
                                    value: bm.id.toString(),
                                    label: bm.tenBoMon,
                                    icon: Icons.apartment,
                                  );
                                }).toList();

                                _selectedBoMon ??= _boMonList.isNotEmpty
                                    ? _boMonList.first
                                    : null;

                                return DropdownSelector(
                                  label: 'Bộ môn',
                                  selectedItem: _selectedBoMon,
                                  items: _boMonList,
                                  onChanged: (item) {
                                    setState(() {
                                      _selectedBoMon = item;
                                      _selectedLecturer = null;

                                      final boMonId = int.tryParse(
                                        item?.value ?? '',
                                      );
                                      print('BoMon ID: $boMonId');
                                      print(
                                        'Số giảng viên lọc được: ${_lecturers.length}',
                                      );

                                      final giangViens = _allUsers.where((
                                        user,
                                      ) {
                                        return user.idBoMon == boMonId;
                                      }).toList();

                                      _lecturers = giangViens.map((gv) {
                                        final label =
                                            gv.hoSo?.hoTen ?? gv.taiKhoan;
                                        return DropdownItem(
                                          value: gv.id.toString(),
                                          label: label,
                                          icon: Icons.person,
                                        );
                                      }).toList();

                                      if (_lecturers.isNotEmpty) {
                                        _selectedLecturer = _lecturers.first;
                                      }
                                    });
                                  },
                                );
                              }

                              if (state is NganhKhoaError) {
                                return Text('Lỗi tải bộ môn: ${state.message}');
                              }

                              return const SizedBox();
                            },
                          ),

                          const SizedBox(height: 20),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is UserLoaded) {
                                _allUsers = state.users;

                                return DropdownSelector(
                                  label: 'Giảng viên',
                                  selectedItem: _selectedLecturer,
                                  items: _lecturers,
                                  onChanged: (item) {
                                    setState(() {
                                      _selectedLecturer = item;
                                    });
                                  },
                                );
                              }
                              if (state is UserError) {
                                return Text(
                                  "Lỗi tải giảng viên: ${state.message}",
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Lịch học các lớp:',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<LopHocPhanBloc, LopHocPhanState>(
                    builder: (context, state) {
                      if (state is LopHocPhanLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is LopHocPhanLoaded) {
                        final selectedWeekId = int.tryParse(
                          _selectedWeek?.value ?? '0',
                        );
                        final filteredLopHocPhans = state.lopHocPhans.where((
                          lhp,
                        ) {
                          final matchGV = _selectedLecturer == null
                              ? true
                              : lhp.gv?.id.toString() ==
                                    _selectedLecturer?.value;

                          final hasScheduleInWeek = lhp.thoiKhoaBieu.any(
                            (tkb) => tkb.idTuan == selectedWeekId,
                          );
                          print(
                            'Giảng viên đã chọn: ${_selectedLecturer?.value}',
                          );
                          print('Tuần đã chọn: ${_selectedWeek?.value}');
                          print(
                            'Tổng số lớp học phần: ${state.lopHocPhans.length}',
                          );

                          for (var lhp in state.lopHocPhans) {
                            print('Lớp ${lhp.id} - GV: ${lhp.gv?.id}');
                            for (var tkb in lhp.thoiKhoaBieu) {
                              print(
                                '  TKB: idTuan=${tkb.idTuan}, ngày=${tkb.ngay}',
                              );
                            }
                          }
                          print(
                            'Giảng viên đã chọn: ${_selectedLecturer?.value}',
                          );
                          print('selectedWeekId: $selectedWeekId');

                          return matchGV;
                        }).toList();

                        return Column(
                          children: filteredLopHocPhans.map((lophp) {
                            return Column(
                              children: [
                                Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        BlocBuilder<TuanBloc, TuanState>(
                                          builder: (context, tuanState) {
                                            if (tuanState is TuanLoaded) {
                                              final selectedWeekId =
                                                  int.tryParse(
                                                    _selectedWeek?.value ?? '0',
                                                  );
                                              final danhSachTuan =
                                                  tuanState.danhSachTuan;

                                              final tuan = danhSachTuan
                                                  .firstWhere(
                                                    (t) =>
                                                        t.tuan ==
                                                        selectedWeekId,
                                                    orElse: () =>
                                                        danhSachTuan.first,
                                                  );
                                              final ngayBatDau =
                                                  tuan.ngayBatDau;

                                              final tkbTrongTuan = lophp
                                                  .thoiKhoaBieu
                                                  .where(
                                                    (tkb) =>
                                                        tkb.idTuan ==
                                                        selectedWeekId,
                                                  )
                                                  .toList();

                                              Map<String, List<ThoiKhoaBieu>>
                                              tkbTheoThu = {
                                                'Thứ 2': [],
                                                'Thứ 3': [],
                                                'Thứ 4': [],
                                                'Thứ 5': [],
                                                'Thứ 6': [],
                                                'Thứ 7': [],
                                                'Chủ nhật': [],
                                              };

                                              for (var tkb in tkbTrongTuan) {
                                                final ngayHoc = DateTime.parse(
                                                  tkb.ngay,
                                                );
                                                final thu = getThuFromDate(
                                                  ngayHoc,
                                                );
                                                if (tkbTheoThu.containsKey(
                                                  thu,
                                                )) {
                                                  tkbTheoThu[thu]!.add(tkb);
                                                }
                                              }

                                              return BlocBuilder<
                                                PhongBloc,
                                                PhongState
                                              >(
                                                builder: (context, phongState) {
                                                  if (phongState
                                                          is PhongLoaded &&
                                                      ngayBatDau != null) {
                                                    final rooms =
                                                        phongState.rooms;

                                                    return ScheduleDetailEditor(
                                                      lhpId: lophp.id,
                                                      classSchedule: lophp,
                                                      rooms: rooms,
                                                      selectedWeekId:
                                                          selectedWeekId!,
                                                      ngayBatDauTuan:
                                                          ngayBatDau,
                                                      onSave: (newDetail) {},
                                                      tkbTheoThu: tkbTheoThu,
                                                    );
                                                  }

                                                  return const CircularProgressIndicator();
                                                },
                                              );
                                            }

                                            return const SizedBox();
                                          },
                                        ),
                                        const SizedBox(height: 12),
                                        ElevatedButton.icon(
                                          icon: const Icon(
                                            Icons.copy,
                                            color: Colors.white,
                                          ), // icon màu trắng
                                          label: const Text(
                                            'Sao chép lịch',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ), // chữ trắng
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue, // nền xanh dương
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                              horizontal: 24,
                                            ), // tăng chiều cao
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    12,
                                                  ), // bo góc đẹp
                                            ),
                                          ),
                                          onPressed: () {
                                            showScheduleCopyDialog(
                                              context: context,
                                              weeks: _weeks,
                                              onCopy: (sourceWeekId, targetWeekId) {
                                                final tkbIdsToCopy = lophp
                                                    .thoiKhoaBieu
                                                    .where(
                                                      (tkb) =>
                                                          tkb.idTuan ==
                                                          sourceWeekId,
                                                    )
                                                    .map((tkb) => tkb.id)
                                                    .toList();

                                                if (tkbIdsToCopy.isEmpty) {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Không có thời khóa biểu để sao chép!',
                                                      ),
                                                    ),
                                                  );
                                                  return;
                                                }

                                                context
                                                    .read<ThoiKhoaBieuBloc>()
                                                    .add(
                                                      CopyNhieuThoiKhoaBieuWeekEvent(
                                                        tkbIds: tkbIdsToCopy,
                                                        startWeekId:
                                                            sourceWeekId,
                                                        endWeekId: targetWeekId,
                                                      ),
                                                    );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        );
                      }
                      if (state is LopHocPhanError) {
                        return Text('Lỗi tải lớp học phần: ${state.message}');
                      }
                      return const SizedBox();
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}
