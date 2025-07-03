import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_chuong_trinh_dao_tao.dart';
import 'package:portal_ckc/api/model/admin_hoc_ky.dart';
import 'package:portal_ckc/api/model/admin_lich_thi.dart';
import 'package:portal_ckc/api/model/admin_mon_hoc.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lich_thi_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nganh_khoa_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phong_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/event/lich_thi_event.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/event/nganh_khoa_event.dart';
import 'package:portal_ckc/bloc/event/phong_event.dart';
import 'package:portal_ckc/bloc/event/user_event.dart';
import 'package:portal_ckc/bloc/state/lich_thi_state.dart';
import 'package:portal_ckc/bloc/state/lop_hoc_phan_state.dart';
import 'package:portal_ckc/bloc/state/nganh_khoa_state.dart';
import 'package:portal_ckc/bloc/state/phong_state.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';
import 'package:portal_ckc/presentation/sections/card/course_assignment_class_infor_section.dart';
import 'package:portal_ckc/presentation/sections/card/course_assignment_info_section.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/event/nienkhoa_hocky_event.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';
import 'package:portal_ckc/presentation/sections/card/exam_schedule_card.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:collection/collection.dart';

class PageExamScheduleGroupedAdmin extends StatefulWidget {
  @override
  _PageExamScheduleGroupedAdminState createState() =>
      _PageExamScheduleGroupedAdminState();
}

class _PageExamScheduleGroupedAdminState
    extends State<PageExamScheduleGroupedAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isCTCTDTInitialized = false;

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
    context.read<LichThiBloc>().add(FetchLichThi());
    context.read<PhongBloc>().add(FetchRoomsEvent());
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
        if (nganhKhoaState is CTCTDTLoaded && !_isCTCTDTInitialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _allCTCTDT = nganhKhoaState.chiTiet;
              _filterSubjectsByHocKy();
              _isCTCTDTInitialized = true;
            });
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Quản lý lịch thi',
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
                  return Center(child: Text('Lỗi: ${lopState.message}'));
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
                    final instructors = (userState as UserLoaded).users;

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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: CourseInfoSection(
                                      selectedNienKhoaId: _selectedNienKhoaId,
                                      selectedHocKy: _selectedHocKy,
                                      subjects: _filteredMonHocs
                                          .map((m) => m.tenMon)
                                          .toList(),
                                      nienKhoas: nienKhoas,
                                      hocKyList: _hocKyList,
                                      selectedSubject:
                                          _selectedMonHoc?.tenMon ?? '',
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
                                              .firstWhere(
                                                (m) => m.tenMon == subject,
                                              );
                                          _hasUnsavedChanges = true;
                                        });
                                      },
                                      onSave: _saveChanges,
                                    ),
                                  ),
                                ),
                              ),

                              BlocBuilder<LichThiBloc, LichThiState>(
                                builder: (context, lichState) {
                                  if (lichState is! LichThiLoaded) {
                                    return const CircularProgressIndicator();
                                  }
                                  final lichThis = lichState.lichThiList;

                                  return BlocBuilder<PhongBloc, PhongState>(
                                    builder: (context, phongState) {
                                      if (phongState is! PhongLoaded) {
                                        return const CircularProgressIndicator();
                                      }
                                      final rooms = phongState.rooms;

                                      return BlocBuilder<UserBloc, UserState>(
                                        builder: (context, userState) {
                                          if (userState is! UserLoaded) {
                                            return const CircularProgressIndicator();
                                          }
                                          final giangViens = userState.users;

                                          final filteredLops = classes.where((
                                            lop,
                                          ) {
                                            final matchNienKhoa =
                                                _selectedNienKhoaId == null
                                                ? true
                                                : lop.lop.idNienKhoa
                                                          .toString() ==
                                                      _selectedNienKhoaId;

                                            final matchHocKy =
                                                _selectedHocKy == null
                                                ? true
                                                : lop.chuongTrinhDaoTao.chiTiet
                                                          ?.any(
                                                            (ct) =>
                                                                ct.idHocKy ==
                                                                _selectedHocKy!
                                                                    .id,
                                                          ) ??
                                                      false;

                                            final matchMonHoc =
                                                _selectedMonHoc == null
                                                ? true
                                                : lop.tenHocPhan
                                                          .trim()
                                                          .toLowerCase() ==
                                                      _selectedMonHoc!.tenMon
                                                          .trim()
                                                          .toLowerCase();

                                            return matchNienKhoa &&
                                                matchHocKy &&
                                                matchMonHoc;
                                          }).toList();

                                          return Column(
                                            children: filteredLops.map((lop) {
                                              final ExamSchedule? lich =
                                                  lichThis.firstWhereOrNull(
                                                    (e) =>
                                                        e.idLopHocPhan ==
                                                        lop.id,
                                                  );

                                              final defaultSchedule =
                                                  ExamSchedule(
                                                    id: 0,
                                                    idLopHocPhan: lop.id,
                                                    ngayThi: DateFormat(
                                                      'yyyy-MM-dd',
                                                    ).format(DateTime.now()),
                                                    gioBatDau: '08:00',
                                                    idGiamThi1: 0,
                                                    idGiamThi2: 0,
                                                    idPhongThi: 0,
                                                    lanThi: 1,
                                                    thoiGianThi: 90,
                                                    trangThai: 0,
                                                    lopHocPhan: lop,
                                                    giamThi1: User.empty(),
                                                    giamThi2: User.empty(),
                                                    phong: null,
                                                  );

                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8,
                                                    ),
                                                child: ExamScheduleCard(
                                                  schedule:
                                                      lich ?? defaultSchedule,
                                                  lecturers: giangViens
                                                      .map(
                                                        (gv) => DropdownItem(
                                                          value: gv.id
                                                              .toString(),
                                                          label:
                                                              gv.hoSo?.hoTen ??
                                                              'Không tên',
                                                          icon: Icons.person,
                                                        ),
                                                      )
                                                      .toList(),
                                                  rooms: rooms
                                                      .map(
                                                        (r) => DropdownItem(
                                                          value: r.id
                                                              .toString(),
                                                          label: r.ten,
                                                          icon: Icons.room,
                                                        ),
                                                      )
                                                      .toList(),
                                                  onSave: (updated) {
                                                    if (updated.id == 0) {
                                                      context.read<LichThiBloc>().add(
                                                        CreateLichThi({
                                                          'id_lop_hoc_phan':
                                                              updated
                                                                  .idLopHocPhan,
                                                          'ngay_thi':
                                                              updated.ngayThi,
                                                          'gio_bat_dau':
                                                              updated.gioBatDau,
                                                          'id_giam_thi_1':
                                                              updated
                                                                  .idGiamThi1,
                                                          'id_giam_thi_2':
                                                              updated
                                                                  .idGiamThi2,
                                                          'id_phong_thi':
                                                              updated
                                                                  .idPhongThi,
                                                          'lan_thi':
                                                              updated.lanThi,
                                                          'thoi_gian_thi':
                                                              updated
                                                                  .thoiGianThi,
                                                          'trang_thai':
                                                              updated.trangThai,
                                                        }),
                                                      );
                                                    } else {
                                                      context.read<LichThiBloc>().add(
                                                        UpdateLichThi(
                                                          updated.id,
                                                          {
                                                            'ngay_thi':
                                                                updated.ngayThi,
                                                            'gio_bat_dau':
                                                                updated
                                                                    .gioBatDau,
                                                            'id_giam_thi_1':
                                                                updated
                                                                    .idGiamThi1,
                                                            'id_giam_thi_2':
                                                                updated
                                                                    .idGiamThi2,
                                                            'id_phong_thi':
                                                                updated
                                                                    .idPhongThi,
                                                            'lan_thi':
                                                                updated.lanThi,
                                                            'thoi_gian_thi':
                                                                updated
                                                                    .thoiGianThi,
                                                            'trang_thai':
                                                                updated
                                                                    .trangThai,
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        },
                                      );
                                    },
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
