import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_bloc.dart';
import 'package:portal_ckc/bloc/event/lop_event.dart';
import 'package:portal_ckc/bloc/state/lop_state.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/filter_button_status_student.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';
import 'package:portal_ckc/presentation/sections/card/student_detail_bottom_sheet.dart'
    hide StudentStatus;
import 'package:portal_ckc/presentation/sections/card/student_list_item.dart';

class PageStudentManagementAdmin extends StatefulWidget {
  const PageStudentManagementAdmin({Key? key}) : super(key: key);

  @override
  State<PageStudentManagementAdmin> createState() =>
      _PageStudentManagementAdminState();
}

class _PageStudentManagementAdminState
    extends State<PageStudentManagementAdmin> {
  DropdownItem? _selectedClass;
  StudentStatus? _currentFilter;
  List<SinhVien> _allStudents = [];
  List<DropdownItem> _classNames = [];
  Map<String, int> _lopTenToId = {};
  bool _isDataLoaded = false;

  void _resetStudentPassword(SinhVien student) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã yêu cầu đặt lại mật khẩu cho MSSV: ${student.maSv}'),
      ),
    );
  }

  void _updateStudentStatus(SinhVien updatedStudent) {
    setState(() {
      final index = _allStudents.indexWhere((s) => s.id == updatedStudent.id);
      if (index != -1) _allStudents[index] = updatedStudent;
    });
  }

  void _showStudentDetailBottomSheet(SinhVien student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => StudentDetailBottomSheet(
        student: student,
        onUpdateStatus: _updateStudentStatus,
      ),
    );
  }

  List<SinhVien> get _filteredStudents {
    return _allStudents.where((s) {
      final matchClass =
          _selectedClass == null ||
          _selectedClass!.value == 'all' ||
          s.idLop == _lopTenToId[_selectedClass!.value];
      final matchStatus =
          _currentFilter == null || s.trangThai == _currentFilter!.index;
      return matchClass && matchStatus;
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    context.read<LopBloc>().add(FetchLopDetail(1));
    context.read<LopBloc>().add(FetchAllLopEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý sinh viên'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<LopBloc, LopDetailState>(
        builder: (context, state) {
          if (state is LopDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AllLopLoaded) {
            _classNames = [
              DropdownItem(
                value: 'all',
                label: 'Tất cả các lớp',
                icon: Icons.class_,
              ),
              ...state.danhSachLop.map((lop) {
                _lopTenToId[lop.tenLop] = lop.id;
                return DropdownItem(
                  value: lop.tenLop,
                  label: lop.tenLop,
                  icon: Icons.class_,
                );
              }),
            ];
            if (_classNames.isNotEmpty) {
              _selectedClass ??= _classNames.length > 1
                  ? _classNames[1]
                  : _classNames.first;
            }

            // Gọi FetchLopDetail nếu chưa có dữ liệu
            final selectedName = _selectedClass?.value;
            if (selectedName != null && selectedName != 'all') {
              final selectedId = _lopTenToId[selectedName]!;
              context.read<LopBloc>().add(FetchLopDetail(selectedId));
            }

            return const Center(child: CircularProgressIndicator());
          }

          if (state is LopDetailLoaded) {
            if (!_isDataLoaded) {
              _allStudents = state.data.sinhViens;
              _lopTenToId[state.data.lop.tenLop] = state.data.lop.id;

              if (_classNames.isNotEmpty) {
                if (_classNames.isNotEmpty) {
                  _selectedClass ??= _classNames.firstWhere(
                    (e) => e.value == state.data.lop.tenLop,
                    orElse: () => _classNames.first,
                  );
                }
              }

              _isDataLoaded = true;
            }

            return Column(
              children: [
                // BỘ LỌC LỚP
                Card(
                  margin: const EdgeInsets.all(16),
                  elevation: 4,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownSelector(
                      label: 'Danh sách sinh viên theo lớp',
                      selectedItem: _selectedClass,
                      items: _classNames,
                      onChanged: (item) {
                        setState(() {
                          _selectedClass = item;
                          _isDataLoaded = false;
                        });
                        final selectedName = item?.value;
                        if (selectedName != null &&
                            selectedName != 'all' &&
                            _lopTenToId.containsKey(selectedName)) {
                          final selectedId = _lopTenToId[selectedName]!;
                          context.read<LopBloc>().add(
                            FetchLopDetail(selectedId),
                          );
                        }
                      },
                    ),
                  ),
                ),

                // BỘ LỌC TRẠNG THÁI
                FilterButtonsRow(
                  currentFilter: _currentFilter,
                  onFilterChanged: (status) {
                    setState(() {
                      _currentFilter = status as StudentStatus?;
                    });
                  },
                ),
                const SizedBox(height: 8),

                // DANH SÁCH SINH VIÊN
                Expanded(
                  child: _filteredStudents.isEmpty
                      ? const Center(
                          child: Text(
                            'Không tìm thấy sinh viên nào phù hợp.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredStudents.length,
                          itemBuilder: (context, index) {
                            final student = _filteredStudents[index];
                            return StudentListItem(
                              student: student,
                              onDetailPressed: () =>
                                  _showStudentDetailBottomSheet(student),
                              onResetPasswordPressed: () =>
                                  _resetStudentPassword(student),
                            );
                          },
                        ),
                ),
              ],
            );
          }

          if (state is LopDetailError) {
            return Center(child: Text('Lỗi: ${state.message}'));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
