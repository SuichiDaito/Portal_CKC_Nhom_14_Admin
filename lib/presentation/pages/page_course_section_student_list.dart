import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';
import 'package:portal_ckc/bloc/bloc_event_state/cap_nhat_diem_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/sinh_vien_lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/event/cap_nhat_diem_event.dart';
import 'package:portal_ckc/bloc/event/sinh_vien_lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/cap_nhat_diem_state.dart';
import 'package:portal_ckc/bloc/state/sinh_vien_lop_hoc_phan_state.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_studen_infor_class_section.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_student_score_item_section.dart';
import 'package:portal_ckc/utils/export_to_excel.dart';

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
  String _searchQuery = '';

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
                print(state.message);
                return Center(child: Text(state.message));
              } else if (state is SinhVienLhpLoaded) {
                final classInfo = state.lopHocPhan;
                final students = state.danhSach;
                final trangThaiLop = classInfo?.trangThaiNopBangDiem;
                return Column(
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

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Tìm sinh viên...',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value.toLowerCase();
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(
                              Icons.file_download,
                              color: Colors.green,
                            ),
                            tooltip: "Xuất Excel",
                            onPressed: () async {
                              await ExportToExcel(students);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("✅ Xuất Excel thành công"),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: Colors.deepOrange,
                            ),
                            tooltip: "Gửi điểm đến SV",
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "🔄 Đang phát triển tính năng gửi điểm",
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 16),
                        children: [
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
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if ((trangThaiLop ?? 0) == 3) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Lớp học phần đã hoàn tất, không thể nộp điểm nữa!",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  final selectedStudents = students
                                      .where((s) => s.isSelected)
                                      .toList();
                                  if (selectedStudents.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Vui lòng chọn ít nhất 1 sinh viên để nộp điểm!",
                                        ),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                    return;
                                  }
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        "Xác nhận cập nhật điểm",
                                      ),
                                      content: Text(
                                        "Sĩ số lớp hiện đang có:${classInfo!.soLuongSinhVien} \nBạn đang cập nhật điểm cho ${selectedStudents.length} sinh viên.\nBạn có chắc chắn muốn tiếp tục?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Huỷ"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(
                                              context,
                                            ); // Đóng dialog

                                            final request = CapNhatDiemRequest(
                                              idLopHocPhan: widget.idLopHocPhan,
                                              students: selectedStudents
                                                  .map((s) => s.sinhVien.id!)
                                                  .toList(),
                                              diemChuyenCan: {
                                                for (var s in selectedStudents)
                                                  s.sinhVien.id!:
                                                      s.diemChuyenCan ?? 0.0,
                                              },
                                              diemQuaTrinh: {
                                                for (var s in selectedStudents)
                                                  s.sinhVien.id!:
                                                      s.diemQuaTrinh ?? 0.0,
                                              },
                                              diemThiLan1: {
                                                for (var s in selectedStudents)
                                                  s.sinhVien.id!:
                                                      s.diemThiLan1 ?? 0.0,
                                              },
                                              diemThiLan2: {
                                                for (var s in selectedStudents)
                                                  s.sinhVien.id!:
                                                      s.diemThiLan2 ?? 0.0,
                                              },
                                            );

                                            context.read<CapNhatDiemBloc>().add(
                                              SubmitCapNhatDiem(request),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue.shade700,
                                          ),
                                          child: const Text("Xác nhận"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.done_all),
                                label: const Text("Cập nhật điểm"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ...students
                              .where(
                                (student) => student.sinhVien.hoSo.hoTen
                                    .toLowerCase()
                                    .contains(_searchQuery),
                              )
                              .map(
                                (student) => StudentItemSection(
                                  trangThaiLop: trangThaiLop ?? 0,
                                  student: student,
                                  showCheckbox: true,
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
