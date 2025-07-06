import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_phong_khoa.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nganh_khoa_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/event/nganh_khoa_event.dart';
import 'package:portal_ckc/bloc/event/user_event.dart';
import 'package:portal_ckc/bloc/state/nganh_khoa_state.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/filter_buttons_row_teacher.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';
import 'package:portal_ckc/presentation/sections/card/teacher_detail_bottom_sheet.dart';
import 'package:portal_ckc/presentation/sections/card/teacher_list_item.dart';

class PageTeacherManagementAdmin extends StatefulWidget {
  const PageTeacherManagementAdmin({Key? key}) : super(key: key);

  @override
  _PageTeacherManagementAdminState createState() =>
      _PageTeacherManagementAdminState();
}

class _PageTeacherManagementAdminState
    extends State<PageTeacherManagementAdmin> {
  List<BoMon> _allDepartments = [];
  List<DropdownItem> _filteredDepartments = [];
  List<DropdownItem> _faculties = [];

  DropdownItem? _selectedFaculty;
  DropdownItem? _selectedDepartment;
  TeacherPosition? _currentFilter;
  List<User> _allTeachers = [];

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUsersEvent());
    context.read<NganhKhoaBloc>().add(FetchBoMonEvent());
  }

  int? _getRoleIdFromPosition(TeacherPosition? position) {
    switch (position) {
      case TeacherPosition.director:
        return 1;
      case TeacherPosition.dean:
        return 2;
      case TeacherPosition.viceDean:
        return 3;
      case TeacherPosition.staff:
        return 4;
      case TeacherPosition.lecturer:
        return 5;
      default:
        return null;
    }
  }

  List<User> get _filteredTeachers {
    var teachers = _allTeachers;

    if (_selectedFaculty != null && _selectedFaculty!.value != 'all') {
      teachers = teachers
          .where(
            (t) => t.boMon?.nganhHoc?.khoa?.tenKhoa == _selectedFaculty!.label,
          )
          .toList();
    }

    if (_selectedDepartment != null && _selectedDepartment!.value != 'all') {
      teachers = teachers
          .where((t) => t.boMon?.tenBoMon == _selectedDepartment!.label)
          .toList();
    }

    if (_currentFilter != null) {
      final roleId = _getRoleIdFromPosition(_currentFilter);
      if (roleId != null) {
        teachers = teachers
            .where((t) => t.roles.any((role) => role.id == roleId))
            .toList();
      }
    }

    return teachers;
  }

  void _updateTeacherPosition(User updatedTeacher) {
    setState(() {
      final index = _allTeachers.indexWhere((t) => t.id == updatedTeacher.id);
      if (index != -1) {
        _allTeachers[index] = updatedTeacher;
      }
    });
  }

  void _resetTeacherPassword(User teacher) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã yêu cầu đặt lại mật khẩu cho GV: ${teacher.hoSo?.hoTen} - ${teacher.taiKhoan}',
        ),
      ),
    );
  }

  void _showTeacherDetailBottomSheet(User teacher) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => TeacherDetailBottomSheet(
        teacher: teacher,
        onUpdatePosition: (updatedTeacher) =>
            _updateTeacherPosition(updatedTeacher),
      ),
    );
  }

  void _filterDepartmentsByKhoa(String? khoaLabel) {
    setState(() {
      final filtered = _allDepartments
          .where(
            (b) => khoaLabel == null || khoaLabel == 'Tất cả các khoa'
                ? true
                : b.nganhHoc?.khoa?.tenKhoa == khoaLabel,
          )
          .toList();

      _filteredDepartments = filtered
          .map(
            (b) => DropdownItem(
              value: b.tenBoMon,
              label: b.tenBoMon,
              icon: Icons.account_tree,
            ),
          )
          .toList();

      if (_filteredDepartments.isNotEmpty) {
        _selectedDepartment = _filteredDepartments.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý giáo viên'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          BlocListener<NganhKhoaBloc, NganhKhoaState>(
            listener: (context, state) {
              if (state is BoMonLoaded) {
                _allDepartments = state.boMons;
                final khoaSet = _allDepartments
                    .map((b) => b.nganhHoc?.khoa?.tenKhoa)
                    .toSet();
                _faculties = khoaSet
                    .map(
                      (tenKhoa) => DropdownItem(
                        value: tenKhoa ?? '',
                        label: tenKhoa ?? '',
                        icon: Icons.school,
                      ),
                    )
                    .toList();
                _faculties.insert(
                  0,
                  DropdownItem(
                    value: 'all',
                    label: 'Tất cả các khoa',
                    icon: Icons.school,
                  ),
                );

                _selectedFaculty ??= _faculties.first;
                _filterDepartmentsByKhoa(_selectedFaculty?.label);
              }
            },
            child: const SizedBox.shrink(),
          ),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is UserLoaded) {
                  _allTeachers = state.users;

                  return Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0,
                        ),
                        elevation: 4.0,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              DropdownSelector(
                                label: 'Khoa',
                                selectedItem: _selectedFaculty,
                                items: _faculties,
                                onChanged: (item) {
                                  setState(() {
                                    _selectedFaculty = item;
                                    _filterDepartmentsByKhoa(item?.label);
                                  });
                                },
                              ),
                              const SizedBox(height: 8),
                              DropdownSelector(
                                label: 'Bộ môn',
                                selectedItem: _selectedDepartment,
                                items: [
                                  DropdownItem(
                                    value: 'all',
                                    label: 'Tất cả các bộ môn',
                                    icon: Icons.account_tree,
                                  ),
                                  ..._filteredDepartments,
                                ],
                                onChanged: (item) {
                                  setState(() {
                                    _selectedDepartment = item;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      FilterButtonsRowTeacher(
                        currentFilter: _currentFilter,
                        onFilterChanged: (position) {
                          setState(() {
                            _currentFilter = position as TeacherPosition?;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: _filteredTeachers.isEmpty
                            ? const Center(
                                child: Text(
                                  'Không tìm thấy giáo viên nào phù hợp.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _filteredTeachers.length,
                                itemBuilder: (context, index) {
                                  final teacher = _filteredTeachers[index];
                                  return TeacherListItem(
                                    teacher: teacher,
                                    onDetailPressed: () =>
                                        _showTeacherDetailBottomSheet(teacher),
                                    onResetPasswordPressed: () =>
                                        _resetTeacherPassword(teacher),
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                }

                if (state is UserError) {
                  return Center(
                    child: Text(
                      'Không thể truy cập chức năng này, vui lòng thử lại sau',
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
