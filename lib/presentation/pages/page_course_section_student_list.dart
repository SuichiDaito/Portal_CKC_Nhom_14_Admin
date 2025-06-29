import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';
import 'package:portal_ckc/bloc/bloc_event_state/cap_nhat_diem_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/sinh_vien_lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/event/cap_nhat_diem_event.dart';
import 'package:portal_ckc/bloc/event/sinh_vien_lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/cap_nhat_diem_state.dart';
import 'package:portal_ckc/bloc/state/sinh_vien_lop_hoc_phan_state.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_studen_infor_class_section.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_student_score_item_section.dart';

class PageCourseSectionStudentList extends StatefulWidget {
  final int idLopHocPhan;
  const PageCourseSectionStudentList({Key? key, required this.idLopHocPhan})
    : super(key: key);

  @override
  State<PageCourseSectionStudentList> createState() =>
      _PageCourseSectionStudentListState();
}

class _PageCourseSectionStudentListState
    extends State<PageCourseSectionStudentList> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SinhVienLhpBloc()..add(FetchSinhVienLhp(widget.idLopHocPhan)),
        ),
        BlocProvider(create: (_) => CapNhatDiemBloc()),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text(
            'Danh sách sinh viên',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        body: BlocListener<CapNhatDiemBloc, CapNhatDiemState>(
          listener: (context, state) {
            if (state is CapNhatDiemSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is CapNhatDiemFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<SinhVienLhpBloc, SinhVienLhpState>(
            builder: (context, state) {
              if (state is SinhVienLhpLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SinhVienLhpError) {
                return Center(child: Text(state.message));
              } else if (state is SinhVienLhpLoaded) {
                final classInfo = state.lopHocPhan;
                final students = state.danhSach;

                return ListView(
                  padding: const EdgeInsets.only(bottom: 16),
                  children: [
                    if (classInfo != null)
                      ClassListStudenInforClassSection(
                        classInfo: ClassInfo(
                          className: classInfo.lop.tenLop,
                          totalStudents: students.length,
                          subject: classInfo.tenHocPhan,
                          totalCredits:
                              classInfo.chuongTrinhDaoTao.tenChuongTrinhDaoTao,
                        ),
                      ),
                    ...students.map(
                      (student) => StudentItemSection(
                        student: student,
                        showCheckbox: false,
                        isGradeInputMode: false,
                        onCheckboxChanged: (s, selected) {
                          setState(() {
                            s.isSelected = selected;
                          });
                        },
                        onGradeSubmit: (updatedStudent) {
                          final request = CapNhatDiemRequest(
                            idLopHocPhan: widget.idLopHocPhan,
                            students: [student.sinhVien.id!],
                            diemChuyenCan: {
                              student.sinhVien.id!:
                                  updatedStudent.diemChuyenCan ?? 0.0,
                            },
                            diemQuaTrinh: {
                              student.sinhVien.id!:
                                  updatedStudent.diemQuaTrinh ?? 0.0,
                            },
                            diemThi: {
                              student.sinhVien.id!:
                                  updatedStudent.diemThi ?? 0.0,
                            },
                            diemLyThuyet: {
                              student.sinhVien.id!:
                                  updatedStudent.diemLyThuyet ?? 0.0,
                            },
                          );

                          context.read<CapNhatDiemBloc>().add(
                            SubmitCapNhatDiem(request),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text('Không có dữ liệu'));
            },
          ),
        ),
      ),
    );
  }
}
