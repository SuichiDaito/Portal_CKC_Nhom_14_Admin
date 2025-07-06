import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/bloc/bloc_event_state/diem_rl_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/event/diem_rl_event.dart';
import 'package:portal_ckc/bloc/event/nienkhoa_hocky_event.dart';
import 'package:portal_ckc/bloc/state/diem_rl_state.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';
import 'package:portal_ckc/presentation/sections/bulk_action_section.dart';
import 'package:portal_ckc/presentation/sections/header_filter_section.dart';
import 'package:portal_ckc/presentation/sections/student_list_section.dart';

class PageConductEvaluationAdmin extends StatefulWidget {
  final int lopId;
  final int idNienKhoa;

  const PageConductEvaluationAdmin({
    super.key,
    required this.lopId,
    required this.idNienKhoa,
  });

  @override
  State<PageConductEvaluationAdmin> createState() =>
      _PageConductEvaluationAdminState();
}

class _PageConductEvaluationAdminState
    extends State<PageConductEvaluationAdmin> {
  bool selectAll = false;
  String selectedMonth = '1';
  String selectedYear = '2025';
  bool isEditing = false;
  String selectedScore = 'A';
  List<StudentWithScore> students = [];
  int? selectedNienKhoaId;
  List<NienKhoa> nienKhoaList = [];

  final List<String> months = List.generate(12, (index) => '${index + 1}');
  List<String> years = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = '${now.month}';
    selectedYear = '${now.year}';
    selectedNienKhoaId = widget.idNienKhoa;
    _updateYearsFromNienKhoa(selectedNienKhoaId);
    context.read<DiemRlBloc>().add(
      FetchDiemRenLuyen(
        widget.lopId,
        int.parse(selectedMonth),
        int.parse(selectedYear),
      ),
    );
    context.read<NienKhoaHocKyBloc>().add(FetchNienKhoaHocKy());
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var student in students) {
        student.isSelected = selectAll;
      }
    });
  }

  String convertScoreToNumber(String score) {
    switch (score) {
      case 'A':
        return '1';
      case 'B':
        return '2';
      case 'C':
        return '3';
      case 'D':
        return '4';
      default:
        return '1';
    }
  }

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        for (var s in students) {
          s.isSelected = false;
        }
        selectAll = false;
      }
    });
  }

  void _saveScores() {
    final selectedStudents = students
        .where((s) => s.isSelected)
        .map((s) => s.sinhVien.id)
        .toList();

    if (selectedStudents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ít nhất 1 sinh viên')),
      );
      return;
    }

    context.read<DiemRlBloc>().add(
      UpdateBulkDiemRenLuyen(
        thoiGian: selectedMonth,
        nam: selectedYear,
        xepLoai: convertScoreToNumber(selectedScore),
        selectedStudentIds: selectedStudents,
      ),
    );

    setState(() {
      isEditing = false;
      selectAll = false;
      for (var s in students) {
        s.isSelected = false;
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      _reloadData();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đang cập nhật điểm...')));
  }

  void _onMonthChanged(String? value) {
    if (value == null) return;
    setState(() {
      selectedMonth = value;
      students = [];
    });
    context.read<DiemRlBloc>().add(
      FetchDiemRenLuyen(
        widget.lopId,
        int.parse(selectedMonth),
        int.parse(selectedYear),
      ),
    );
  }

  void _onYearChanged(String? value) {
    if (value == null) return;
    setState(() {
      selectedYear = value;
      students = [];
    });
    context.read<DiemRlBloc>().add(
      FetchDiemRenLuyen(
        widget.lopId,
        int.parse(selectedMonth),
        int.parse(selectedYear),
      ),
    );
  }

  void _updateYearsFromNienKhoa(int? id) {
    final found = nienKhoaList.firstWhere(
      (nk) => nk.id == id,
      orElse: () => NienKhoa(
        id: 0,
        tenNienKhoa: '',
        namBatDau: '',
        namKetThuc: '',
        trangThai: 0,
        hocKys: [],
      ),
    );

    if (found.namBatDau.isNotEmpty && found.namKetThuc.isNotEmpty) {
      final start = int.tryParse(found.namBatDau) ?? DateTime.now().year;
      final end = int.tryParse(found.namKetThuc) ?? start;
      years = List.generate(end - start + 1, (i) => '${start + i}');
      if (!years.contains(selectedYear)) {
        selectedYear = years.first;
      }
    }
  }

  String _getScoreLabel(String score) {
    switch (score) {
      case 'A':
        return 'Tốt';
      case 'B':
        return 'Khá';
      case 'C':
        return 'Trung bình';
      case 'D':
        return 'Yếu';
      case 'E':
        return 'Kém';
      case 'F':
        return 'Rất kém';
      default:
        return 'Chưa có';
    }
  }

  void _onStudentSelectChanged(bool? value, int index) {
    setState(() {
      students[index].isSelected = value ?? false;
    });
  }

  void _onStudentScoreChanged(String? value, int index) {
    if (value == null) return;
    setState(() {
      students[index].conductScore = value;
    });

    context.read<DiemRlBloc>().add(
      UpdateBulkDiemRenLuyen(
        thoiGian: selectedMonth,
        nam: selectedYear,
        xepLoai: convertScoreToNumber(value),
        selectedStudentIds: [students[index].sinhVien.id],
      ),
    );
    isEditing = false;
  }

  void _applyScoreToSelected(String? value) {
    if (value == null) return;
    setState(() {
      selectedScore = value;
      for (var student in students) {
        if (student.isSelected) {
          student.conductScore = selectedScore;
        }
      }
    });
  }

  void _reloadData() {
    context.read<DiemRlBloc>().add(
      FetchDiemRenLuyen(
        widget.lopId,
        int.parse(selectedMonth),
        int.parse(selectedYear),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Nhập điểm rèn luyện',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1976D2),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocListener<NienKhoaHocKyBloc, NienKhoaHocKyState>(
        listener: (context, state) {
          if (state is NienKhoaHocKyLoaded) {
            setState(() {
              nienKhoaList = state.nienKhoas;
              _updateYearsFromNienKhoa(selectedNienKhoaId);
            });
          }
        },
        child: BlocListener<DiemRlBloc, DiemRLState>(
          listener: (context, state) {
            if (state is DiemRLUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              _reloadData();
            } else if (state is DiemRLUpdateFailure || state is DiemRLError) {
              final message = state is DiemRLUpdateFailure
                  ? state.message
                  : (state as DiemRLError).message;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            }
          },
          child: BlocBuilder<DiemRlBloc, DiemRLState>(
            builder: (context, state) {
              if (state is DiemRLLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is DiemRLLoaded) {
                final sinhViens = state.data.sinhViens;

                if (students.isEmpty) {
                  students = sinhViens
                      .map((sv) => StudentWithScore.fromSinhVien(sv: sv))
                      .toList();
                }
              }

              if (selectedNienKhoaId == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final nienKhoaState = context.watch<NienKhoaHocKyBloc>().state;
              if (nienKhoaState is NienKhoaHocKyLoaded) {
                nienKhoaList = nienKhoaState.nienKhoas;
                _updateYearsFromNienKhoa(widget.idNienKhoa);
              }

              return Column(
                children: [
                  HeaderFilterSection(
                    selectedMonth: selectedMonth,
                    selectedYear: selectedYear,
                    months: months,
                    years: years,
                    isEditing: isEditing,
                    onMonthChanged: _onMonthChanged,
                    onYearChanged: _onYearChanged,
                    onToggleEdit: _toggleEditMode,
                    onSave: _saveScores,
                    onReload: _reloadData,
                  ),
                  if (isEditing)
                    BulkActionSection(
                      isEditing: isEditing,
                      selectAll: selectAll,
                      selectedScore: selectedScore,
                      students: students,
                      onSelectAll: _toggleSelectAll,
                      onChangeScore: _applyScoreToSelected,
                    ),
                  Expanded(
                    child: StudentListSection(
                      students: students,
                      isEditing: isEditing,
                      onSelectChanged: _onStudentSelectChanged,
                      onScoreChanged: _onStudentScoreChanged,
                      getScoreLabel: _getScoreLabel,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 12),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Tháng $selectedMonth - Năm $selectedYear',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
