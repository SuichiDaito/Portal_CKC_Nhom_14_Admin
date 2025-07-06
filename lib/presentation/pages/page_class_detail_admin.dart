import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/event/lop_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/bloc/state/lop_state.dart';
import 'package:portal_ckc/presentation/sections/card/class_detail_class_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/class_detail_class_search_bar.dart';
import 'package:portal_ckc/presentation/sections/card/class_detail_student_list.dart';

class PageClassDetailAdmin extends StatefulWidget {
  final Lop lop;

  const PageClassDetailAdmin({super.key, required this.lop});

  @override
  State<PageClassDetailAdmin> createState() => _PageClassDetailAdminState();
}

class _PageClassDetailAdminState extends State<PageClassDetailAdmin> {
  String searchQuery = '';
  String selectedStatus = 'Tất cả';
  late AdminBloc _adminBloc;
  User? _teacher;

  @override
  void initState() {
    super.initState();
    _adminBloc = context.read<AdminBloc>();
    _adminBloc.add(FetchStudentList(widget.lop.id));
    _fetchTeacherInfo(widget.lop.idGvcn);
  }

  Future<void> _fetchTeacherInfo(int idGvcn) async {
    final response = await _adminBloc.service.getUserDetail(idGvcn);
    if (response.isSuccessful && response.body != null) {
      final data = response.body as Map<String, dynamic>;
      setState(() {
        _teacher = User.fromJson(data['user']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LopBloc, LopDetailState>(
      listener: (context, state) {
        if (state is ChangeStudentRoleSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          _adminBloc.add(FetchStudentList(widget.lop.id));
        } else if (state is ChangeStudentRoleFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('❌ ${state.message}')));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: const Text(
            'Chi tiết lớp chủ nhiệm',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF1976D2),
          elevation: 4,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is AdminLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is StudentListLoaded) {
              final studentWithRoles = state.students;

              final secretary = studentWithRoles.firstWhere(
                (s) => s.chucVu == 1,
                orElse: () => StudentWithRole.empty(),
              );

              final secretaryName = secretary?.sinhVien.hoSo.hoTen ?? 'Chưa có';

              final filtered = studentWithRoles.where((sr) {
                final name = sr.sinhVien.hoSo.hoTen.toLowerCase();
                final id = sr.sinhVien.maSv.toLowerCase();
                return name.contains(searchQuery) || id.contains(searchQuery);
              }).toList();

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClassInfoCard(
                      className: widget.lop.tenLop,
                      studentCount: studentWithRoles.length,
                      teacherName: _teacher?.hoSo?.hoTen ?? 'Đang tải...',
                      secretaryName: secretaryName,
                      studentList: studentWithRoles,
                      onSelectSecretary: (newSecretaryId) async {
                        final lopBloc = context.read<LopBloc>();

                        final newSecretaryStudentId = newSecretaryId.toInt();

                        final currentSecretaryStudentId = secretary.sinhVien.id;

                        if (secretary.id != -1 &&
                            secretary.id != newSecretaryId) {
                          lopBloc.add(
                            ChangeStudentRoleEvent(
                              sinhVienId: currentSecretaryStudentId,
                              chucVu: 0,
                            ),
                          );
                        }

                        lopBloc.add(
                          ChangeStudentRoleEvent(
                            sinhVienId: newSecretaryStudentId,
                            chucVu: 1,
                          ),
                        );
                      },
                    ),
                    ClassSearchBar(
                      searchQuery: searchQuery,
                      selectedStatus: selectedStatus,
                      onSearchChanged: (value) =>
                          setState(() => searchQuery = value),
                      onStatusChanged: (value) =>
                          setState(() => selectedStatus = value),
                      studentList: filtered,
                      idClass: widget.lop.id,
                      idNienKhoa: widget.lop.idNienKhoa,
                    ),
                    const SizedBox(height: 16),
                    StudentList(
                      studentList: filtered,
                      onTapStudent: (sv) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Thông tin sinh viên'),
                            content: Text(
                              'Tên: ${sv.sinhVien.hoSo.hoTen}// ${sv.sinhVien.id}\nMSSV: ${sv.sinhVien.maSv}\nChức vụ: ${sv.chucVu == 1 ? 'Thư ký' : 'Không có'}\nTrạng thái: ${{0: 'Đang học', 1: 'Bảo lưu', 2: 'Đã tốt nghiệp'}[sv.sinhVien.trangThai] ?? 'Không rõ'}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Đóng'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            if (state is AdminError) {
              return Center(child: Text('❌ Lôi hiển thị dữ liệu'));
            }

            return const Center(child: Text('Không có dữ liệu'));
          },
        ),
      ),
    );
  }
}
