import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_chuong_trinh_dao_tao.dart';
import 'package:portal_ckc/api/model/admin_hoc_ky.dart';
import 'package:portal_ckc/api/model/admin_mon_hoc.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nganh_khoa_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/event/nganh_khoa_event.dart';
import 'package:portal_ckc/bloc/event/user_event.dart';
import 'package:portal_ckc/bloc/state/lop_hoc_phan_state.dart';
import 'package:portal_ckc/bloc/state/nganh_khoa_state.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';
import 'package:portal_ckc/presentation/sections/card/course_assignment_class_infor_section.dart';
import 'package:portal_ckc/presentation/sections/card/course_assignment_info_section.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/event/nienkhoa_hocky_event.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';

class PageCourseAssignmentAdmin extends StatefulWidget {
  @override
  _PageCourseAssignmentAdminState createState() =>
      _PageCourseAssignmentAdminState();
}

class _PageCourseAssignmentAdminState extends State<PageCourseAssignmentAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<User> instructors = [];

  String? _selectedNienKhoaId;
  HocKy? _selectedHocKy;
  MonHoc? _selectedMonHoc;
  List<HocKy> _hocKyList = [];
  bool _hasUnsavedChanges = false;

  List<ChiTietChuongTrinhDaoTao> _allCTCTDT = [];
  List<MonHoc> _filteredMonHocs = [];

  @override
  void initState() {
    super.initState();
    context.read<LopHocPhanBloc>().add(FetchALLLopHocPhan());
    context.read<UserBloc>().add(FetchUsersEvent());
    context.read<NienKhoaHocKyBloc>().add(FetchNienKhoaHocKy());
    context.read<NganhKhoaBloc>().add(FetchCTCTDTEvent());
  }

  void _onHocKySelected(HocKy hocKy) {
    setState(() {
      _selectedHocKy = hocKy;
      _hasUnsavedChanges = true;
      _filteredMonHocs = _allCTCTDT
          .where((ct) => ct.idHocKy == hocKy.id && ct.monHoc != null)
          .map((ct) => ct.monHoc!)
          .toSet()
          .toList();
      _selectedMonHoc = null;
    });
    _filterSubjectsByHocKy();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã lưu thay đổi thành công!'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        _hasUnsavedChanges = false;
      });
    }
  }

  void _filterSubjectsByHocKy() {
    if (_selectedHocKy == null) return;

    final idHocKy = _selectedHocKy!.id;

    setState(() {
      _filteredMonHocs = _allCTCTDT
          .where((ct) => ct.idHocKy == idHocKy && ct.monHoc != null)
          .map((ct) => ct.monHoc!)
          .toSet()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NganhKhoaBloc, NganhKhoaState>(
      builder: (context, nganhKhoaState) {
        if (nganhKhoaState is CTCTDTLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _allCTCTDT = nganhKhoaState.chiTiet;
              _filterSubjectsByHocKy();
            });
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Phân công lớp học phần',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            iconTheme: const IconThemeData(color: Colors.white),
          ),

          body: Form(
            key: _formKey,
            child: BlocBuilder<LopHocPhanBloc, LopHocPhanState>(
              builder: (context, lopState) {
                if (lopState is LopHocPhanLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (lopState is LopHocPhanError) {
                  return Center(
                    child: Text(
                      'Không thể truy cập chức năng này, vui lòng thử lại sau.',
                    ),
                  );
                }
                if (lopState is! LopHocPhanLoaded) {
                  return const Center(child: Text('Đang tải lớp học phần...'));
                }
                final classes = lopState.lopHocPhans;

                return BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (userState is UserError) {
                      return Center(child: Text('Lỗi tải giảng viên'));
                    }
                    if (userState is UserLoaded) {
                      instructors = userState.users;
                      // Tiếp tục xử lý
                    } else {
                      // Xử lý trường hợp khác (ví dụ: loading, error,...)
                    }

                    return BlocBuilder<NienKhoaHocKyBloc, NienKhoaHocKyState>(
                      builder: (context, nkState) {
                        if (nkState is NienKhoaHocKyLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (nkState is NienKhoaHocKyError) {
                          return Center(
                            child: Text(
                              'Lỗi tải niên khóa: ${nkState.message}',
                            ),
                          );
                        }
                        final nienKhoas =
                            (nkState as NienKhoaHocKyLoaded).nienKhoas;
                        final filteredClasses = classes.where((lop) {
                          final okNK = _selectedNienKhoaId == null
                              ? true
                              : lop.lop.idNienKhoa.toString() ==
                                    _selectedNienKhoaId;

                          final okHK = _selectedHocKy == null
                              ? true
                              : lop.chuongTrinhDaoTao.chiTiet?.any(
                                      (ct) => ct.idHocKy == _selectedHocKy!.id,
                                    ) ??
                                    false;

                          final okTenMon = _selectedMonHoc == null
                              ? true
                              : lop.tenHocPhan.trim().toLowerCase() ==
                                    _selectedMonHoc!.tenMon
                                        .trim()
                                        .toLowerCase();

                          return okNK && okHK && okTenMon;
                        }).toList();

                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CourseInfoSection(
                                selectedNienKhoaId: _selectedNienKhoaId,
                                selectedHocKy: _selectedHocKy,
                                subjects: _filteredMonHocs
                                    .map((m) => m.tenMon)
                                    .toList(),
                                nienKhoas: nienKhoas,
                                hocKyList: _hocKyList,
                                selectedSubject: _selectedMonHoc?.tenMon ?? '',
                                onNienKhoaChanged: (value) {
                                  final sel = nienKhoas.firstWhere(
                                    (e) => e.id.toString() == value,
                                  );
                                  setState(() {
                                    _selectedNienKhoaId = value;
                                    _hocKyList = sel.hocKys;
                                    _selectedHocKy = null;
                                    _filteredMonHocs.clear();
                                    _hasUnsavedChanges = true;
                                  });
                                },
                                onHocKyChanged: _onHocKySelected,
                                onSubjectChanged: (subject) {
                                  setState(() {
                                    _selectedMonHoc = _filteredMonHocs
                                        .firstWhere((m) => m.tenMon == subject);
                                    _hasUnsavedChanges = true;
                                  });
                                },
                                onSave: _saveChanges,
                              ),
                              const SizedBox(height: 20),
                              ClassListSection(
                                classes: filteredClasses,
                                instructors: instructors,
                                onClassInfoChanged: (lopId, field, value) {
                                  context.read<LopHocPhanBloc>().add(
                                    PhanCongGiangVienEvent(
                                      lopHocPhanId: int.parse(lopId),
                                      idGiangVien: int.parse(value),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
