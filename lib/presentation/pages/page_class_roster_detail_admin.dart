import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/sinh_vien_lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/event/sinh_vien_lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/sinh_vien_lop_hoc_phan_state.dart';
import 'package:portal_ckc/presentation/sections/card/build_edit_table_row.dart';
import 'package:portal_ckc/presentation/sections/card/class_section_info_card.dart';

class PageClassRosterDetailAdmin extends StatefulWidget {
  final int idLopHocPhan;
  const PageClassRosterDetailAdmin({Key? key, required this.idLopHocPhan})
    : super(key: key);

  @override
  State<PageClassRosterDetailAdmin> createState() =>
      _PageClassRosterDetailAdminState();
}

class _PageClassRosterDetailAdminState
    extends State<PageClassRosterDetailAdmin> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SinhVienLhpBloc()..add(FetchSinhVienLhp(widget.idLopHocPhan)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text(
            'Danh sách sinh viên',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          actions: [
            IconButton(
              icon: Icon(isEditing ? Icons.save : Icons.edit),
              tooltip: isEditing ? 'Lưu' : 'Sửa',
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
            ),
          ],
        ),
        body: BlocBuilder<SinhVienLhpBloc, SinhVienLhpState>(
          builder: (context, state) {
            if (state is SinhVienLhpLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SinhVienLhpError) {
              return Center(child: Text(state.message));
            }
            if (state is SinhVienLhpLoaded) {
              final lopHocPhan = state.lopHocPhan;
              final danhSachSinhVien = state.danhSach;

              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: state.lopHocPhan != null
                        ? ClassSectionInfoCard(
                            tenLop: state.lopHocPhan!.lop.tenLop,
                            tenHocPhan: state.lopHocPhan!.tenHocPhan,
                            loaiLopHocPhan: state.lopHocPhan!.loaiLopHocPhan,
                            tenChuongTrinhDaoTao: state
                                .lopHocPhan!
                                .chuongTrinhDaoTao
                                .tenChuongTrinhDaoTao,
                            onEditChanged: (value) {
                              setState(() {
                                isEditing = value;
                              });
                              print(isEditing ? 'Đang chỉnh sửa' : 'Đã lưu');
                            },
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(height: 8),
                  ...danhSachSinhVien.map((sv) {
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.blue),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${sv.sinhVien.maSv} - ${sv.sinhVien.hoSo.hoTen}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: _infoRow(
                                    Icons.email,
                                    sv.sinhVien.hoSo.email,
                                  ),
                                ),
                                Expanded(
                                  child: _infoRow(
                                    Icons.male,
                                    sv.sinhVien.hoSo.gioiTinh,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: buildEditableRow(
                                        'Lý thuyết',
                                        sv.diemLyThuyet,
                                        isEditing,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: buildEditableRow(
                                        'Thực hành',
                                        sv.diemThucHanh,
                                        isEditing,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: buildEditableRow(
                                        'Chuyên cần',
                                        sv.diemChuyenCan,
                                        isEditing,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: buildEditableRow(
                                        'Quá trình',
                                        sv.diemQuaTrinh,
                                        isEditing,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: buildEditableRow(
                                        'Điểm thi',
                                        sv.diemThiLan1,
                                        isEditing,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: buildEditableRow(
                                        'Tổng kết',
                                        sv.diemTongKet,
                                        isEditing,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );
            }

            return const Center(child: Text('Không có dữ liệu'));
          },
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
