import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nganh_khoa_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/nganh_khoa_state.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class FilterSection extends StatefulWidget {
  final Function({
    required DropdownItem? selectedSchoolYear,
    required DropdownItem? selectedWeek,
    required DropdownItem? selectedBoMon,
    required DropdownItem? selectedLecturer,
  })
  onFilterChanged;

  const FilterSection({super.key, required this.onFilterChanged});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  // Các biến state của dropdown
  DropdownItem? _selectedSchoolYear;
  DropdownItem? _selectedWeek;
  DropdownItem? _selectedBoMon;
  DropdownItem? _selectedLecturer;
  int selectedWeek = 1;

  List<DropdownItem> _schoolYears = [];
  List<DropdownItem> _weeks = [];
  List<DropdownItem> _boMonList = [];
  List<DropdownItem> _lecturers = [];
  List<User> _allUsers = [];

  bool _isSchoolYearLoaded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // HEADER
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

        // NIÊN KHÓA + TUẦN
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
                      },
                    );
                  }
                  if (state is NienKhoaHocKyError) {
                    return const Text('');
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

                    _selectedWeek ??= _weeks.first;

                    return DropdownSelector(
                      label: 'Tuần',
                      selectedItem: _selectedWeek,
                      items: _weeks,
                      onChanged: (item) {
                        setState(() {
                          _selectedWeek = item;
                          selectedWeek = int.tryParse(item?.value ?? '') ?? 1;
                        });

                        context.read<LopHocPhanBloc>().add(
                          FetchALLLopHocPhan(),
                        );
                      },
                    );
                  }
                  if (tuanState is TuanError) {
                    return const Text('=====');
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // BỘ MÔN
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
                    print('BoMon ID: $boMonId');
                    print('Số giảng viên lọc được: ${_lecturers.length}');

                    final giangViens = _allUsers.where((user) {
                      return user.idBoMon == boMonId;
                    }).toList();

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

            if (state is NganhKhoaError) {
              return Text('');
            }

            return const SizedBox();
          },
        ),
        const SizedBox(height: 20),

        // GIẢNG VIÊN
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
                },
              );
            }
            if (state is UserError) {
              return Text("");
            }

            return const SizedBox();
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
