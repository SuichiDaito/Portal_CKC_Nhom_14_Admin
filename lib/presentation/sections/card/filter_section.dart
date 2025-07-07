import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nganh_khoa_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/event/tuan_event.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/nganh_khoa_state.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class FilterSection extends StatefulWidget {
  final void Function({
    DropdownItem? selectedSchoolYear,
    DropdownItem? selectedWeek,
    DropdownItem? selectedBoMon,
    DropdownItem? selectedLecturer,
  })
  onFilterChanged;

  const FilterSection({super.key, required this.onFilterChanged});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  List<DropdownItem> _schoolYears = [];
  DropdownItem? _selectedSchoolYear;
  bool _isSchoolYearLoaded = false;
  bool _isWeekLoaded = false;

  List<DropdownItem> _weeks = [];
  DropdownItem? _selectedWeek;

  List<DropdownItem> _boMonList = [];
  DropdownItem? _selectedBoMon;
  List<User> _allUsers = [];
  List<DropdownItem> _lecturers = [];
  DropdownItem? _selectedLecturer;
  @override
  void initState() {
    super.initState();
    final currentYear = DateTime.now().year;
    context.read<TuanBloc>().add(FetchTuanEvent(currentYear));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: Colors.blue,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    color: const Color(0xFF1976D2).withOpacity(0.15),
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
                  child: BlocBuilder<NienKhoaHocKyBloc, NienKhoaHocKyState>(
                    builder: (context, state) {
                      if (state is NienKhoaHocKyLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is NienKhoaHocKyLoaded) {
                        if (!_isSchoolYearLoaded) {
                          _schoolYears = state.nienKhoas.map((nk) {
                            return DropdownItem(
                              value: nk.namBatDau,
                              label: nk.tenNienKhoa,
                              icon: Icons.school,
                            );
                          }).toList();
                          _selectedSchoolYear = _schoolYears.isNotEmpty
                              ? _schoolYears.first
                              : null;
                          _isSchoolYearLoaded = true;
                        }

                        return DropdownSelector(
                          label: 'Niên khóa',
                          selectedItem: _selectedSchoolYear,
                          items: _schoolYears,
                          onChanged: (item) {
                            setState(() {
                              _selectedSchoolYear = item;
                            });

                            widget.onFilterChanged(
                              selectedSchoolYear: _selectedSchoolYear,
                              selectedWeek: _selectedWeek,
                              selectedBoMon: _selectedBoMon,
                              selectedLecturer: _selectedLecturer,
                            );
                          },
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
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (tuanState is TuanLoaded) {
                        _weeks = tuanState.danhSachTuan.map((tuan) {
                          return DropdownItem(
                            value: tuan.id.toString(),
                            label: 'Tuần ${tuan.tuan}',
                            icon: Icons.calendar_today,
                          );
                        }).toList();

                        if (!_isWeekLoaded) {
                          _selectedWeek = _weeks.isNotEmpty
                              ? _weeks.first
                              : null;
                          _isWeekLoaded = true;

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            widget.onFilterChanged(
                              selectedSchoolYear: _selectedSchoolYear,
                              selectedWeek: _selectedWeek,
                              selectedBoMon: _selectedBoMon,
                              selectedLecturer: _selectedLecturer,
                            );
                          });
                        }

                        return DropdownSelector(
                          label: 'Tuần',
                          selectedItem: _selectedWeek,
                          items: _weeks,
                          onChanged: (item) {
                            setState(() {
                              _selectedWeek = item;
                            });
                            widget.onFilterChanged(
                              selectedSchoolYear: _selectedSchoolYear,
                              selectedWeek: _selectedWeek,
                              selectedBoMon: _selectedBoMon,
                              selectedLecturer: _selectedLecturer,
                            );
                          },
                        );
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
                  return const Center(child: CircularProgressIndicator());
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

                        final boMonId = int.tryParse(item?.value ?? '');
                        final giangViens = _allUsers
                            .where((user) => user.idBoMon == boMonId)
                            .toList();
                        _lecturers = giangViens.map((gv) {
                          final label = gv.hoSo?.hoTen ?? gv.taiKhoan;
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
                return const SizedBox();
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
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
                      widget.onFilterChanged(
                        selectedSchoolYear: _selectedSchoolYear,
                        selectedWeek: _selectedWeek,
                        selectedBoMon: _selectedBoMon,
                        selectedLecturer: _selectedLecturer,
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
