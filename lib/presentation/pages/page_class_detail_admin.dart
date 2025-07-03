import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
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
              final studentList = state.sinhViens;
              // Tìm sinh viên là thư ký (chucVu == 0)
              final currentSecretary = studentList.firstWhere(
                (s) => s.chucVu == 1,
                orElse: () => SinhVien(
                  id: -1,
                  chucVu: 0,
                  maSv: '',
                  trangThai: 0,
                  hoSo: HoSo(
                    id: -1,
                    hoTen: 'Không có thư ký',
                    email: '',
                    password: '',
                    soDienThoai: '',
                    ngaySinh: '',
                    gioiTinh: '',
                    cccd: '',
                    diaChi: '',
                    anh: '',
                  ),
                  lop: Lop(
                    id: -1,
                    tenLop: '',
                    idNienKhoa: -1,
                    idGvcn: -1,
                    siSo: 0,
                    nienKhoa: NienKhoa(
                      id: -1,
                      tenNienKhoa: '',
                      namBatDau: '',
                      namKetThuc: '',
                      trangThai: 0,
                      hocKys: [],
                    ),
                    giangVien: User(
                      id: -1,
                      hoSo: HoSo(
                        id: -1,
                        hoTen: '',
                        email: '',
                        password: '',
                        soDienThoai: '',
                        ngaySinh: '',
                        gioiTinh: '',
                        cccd: '',
                        diaChi: '',
                        anh: '',
                      ),
                      taiKhoan: '',
                      trangThai: 0,
                      roles: [],
                    ),
                  ),
                  diemRenLuyens: [],
                ),
              );

              final filteredStudents = studentList.where((student) {
                final name = student.hoSo.hoTen.toLowerCase();
                final id = student.maSv.toLowerCase();
                final matchesQuery =
                    name.contains(searchQuery.toLowerCase()) ||
                    id.contains(searchQuery.toLowerCase());
                final matchesStatus =
                    selectedStatus == 'Tất cả' ||
                    student.trangThai.toString() == selectedStatus;
                return matchesQuery && matchesStatus;
              }).toList();

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClassInfoCard(
                      className: widget.lop.tenLop,
                      studentCount: studentList.length,
                      teacherName: _teacher?.hoSo?.hoTen ?? 'Đang tải...',
                      secretaryName: currentSecretary?.hoSo.hoTen ?? 'Chưa có',
                      studentList: studentList,
                      onSelectSecretary: (newSecretaryId) async {
                        final lopBloc = context.read<LopBloc>();

                        if (currentSecretary.id != -1 &&
                            currentSecretary.id != newSecretaryId) {
                          lopBloc.add(
                            ChangeStudentRoleEvent(
                              sinhVienId: currentSecretary.id,
                              chucVu: 0,
                            ),
                          );
                        }

                        lopBloc.add(
                          ChangeStudentRoleEvent(
                            sinhVienId: newSecretaryId,
                            chucVu: 1,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ClassSearchBar(
                      searchQuery: searchQuery,
                      selectedStatus: selectedStatus,
                      onSearchChanged: (value) =>
                          setState(() => searchQuery = value),
                      onStatusChanged: (value) =>
                          setState(() => selectedStatus = value),
                      studentList: filteredStudents,
                      idClass: widget.lop.id,
                      idNienKhoa: widget.lop.idNienKhoa,
                    ),
                    const SizedBox(height: 16),
                    StudentList(
                      studentList: filteredStudents,
                      onTapStudent: (sv) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Thông tin sinh viên'),
                            content: Text(
                              'Tên: ${sv.hoSo.hoTen}\nMSSV: ${sv.maSv}\nChức vụ: ${sv.chucVu == 1 ? 'Thư ký' : 'Không có'}\nTrạng thái: ${{0: 'Đang học', 1: 'Bảo lưu', 2: 'Đã tốt nghiệp'}[sv.trangThai] ?? 'Không rõ'}',
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
              return Center(child: Text('❌ ${state.message}'));
            }

            return const Center(child: Text('Không có dữ liệu'));
          },
        ),
      ),
    );
  }
}
