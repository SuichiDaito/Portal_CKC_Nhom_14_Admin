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
              context.read<SinhVienLhpBloc>().add(
                FetchSinhVienLhp(widget.idLopHocPhan),
              );
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
                final trangThaiLop = classInfo?.trangThaiNopBangDiem;

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

                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: trangThaiLop == 3
                            ? Card(
                                color: Colors.green.shade50,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green.shade600,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Lớp học phần đã hoàn tất',
                                        style: TextStyle(
                                          color: Colors.green.shade800,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ElevatedButton.icon(
                                onPressed: () {
                                  context.read<CapNhatDiemBloc>().add(
                                    UpdateTrangThaiNopDiemEvent(
                                      widget.idLopHocPhan,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.upload),
                                label: const Text(
                                  'Nộp bảng điểm',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                      ),
                    ),

                    ...students.map(
                      (student) => StudentItemSection(
                        trangThaiLop: trangThaiLop ?? 0,
                        student: student,
                        showCheckbox: false,
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
                            diemThiLan1: {
                              student.sinhVien.id!:
                                  updatedStudent.diemThiLan1 ?? 0.0,
                            },
                            diemThiLan2: {
                              student.sinhVien.id!:
                                  updatedStudent.diemThiLan2 ?? 0.0,
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
