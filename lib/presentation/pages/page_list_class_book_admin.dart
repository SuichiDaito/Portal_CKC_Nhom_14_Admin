import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_phieu_len_lop.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phieu_len_lop_bloc.dart';
import 'package:portal_ckc/bloc/event/lop_event.dart';
import 'package:portal_ckc/bloc/event/phieu_len_lop_event.dart';
import 'package:portal_ckc/bloc/state/lop_state.dart';
import 'package:portal_ckc/bloc/state/phieu_len_lop_state.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class PageListClassBookAdmin extends StatefulWidget {
  const PageListClassBookAdmin({Key? key}) : super(key: key);

  @override
  State<PageListClassBookAdmin> createState() => _PageListClassBookAdminState();
}

class _PageListClassBookAdminState extends State<PageListClassBookAdmin> {
  DropdownItem? _selectedClass;
  List<DropdownItem> _classNames = [];
  Map<String, int> _lopTenToId = {};
  List<PhieuLenLop> _allPhieu = [];

  List<PhieuLenLop> get _filteredPhieu {
    return _allPhieu.where((p) {
      final tenLop = p.lopHocPhan?.lop.tenLop;
      return _selectedClass == null ||
          _selectedClass!.value == 'all' ||
          tenLop == _selectedClass!.value;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PhieuLenLopBloc>().add(FetchAllPhieuLenLop());
      context.read<LopBloc>().add(FetchAllLopEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý phiếu lên lớp'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<PhieuLenLopBloc, PhieuLenLopState>(
        builder: (context, phieuState) {
          if (phieuState is PhieuLenLopLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (phieuState is PhieuLenLopLoaded) {
            _allPhieu = phieuState.phieuLenLops;

            final lopSet = <String>{};
            for (var phieu in _allPhieu) {
              final tenLop = phieu.lopHocPhan?.lop.tenLop;
              final idLop = phieu.lopHocPhan?.lop.id;
              if (tenLop != null && idLop != null) {
                lopSet.add(tenLop);
                _lopTenToId[tenLop] = idLop;
              }
            }

            _classNames = [
              DropdownItem(
                value: 'all',
                label: 'Tất cả các lớp',
                icon: Icons.class_,
              ),
              ...lopSet.map(
                (tenLop) => DropdownItem(
                  value: tenLop,
                  label: tenLop,
                  icon: Icons.class_,
                ),
              ),
            ];

            // Gán lớp mặc định nếu chưa có
            _selectedClass ??= _classNames.first;

            return Column(
              children: [
                /// Dropdown lớp
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
                      label: 'Lọc theo lớp học phần',
                      selectedItem: _selectedClass,
                      items: _classNames,
                      onChanged: (item) {
                        setState(() {
                          _selectedClass = item;
                        });
                      },
                    ),
                  ),
                ),

                /// Danh sách phiếu
                Expanded(
                  child: _filteredPhieu.isEmpty
                      ? const Center(
                          child: Text(
                            'Không có phiếu lên lớp nào.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: _filteredPhieu.length,
                          itemBuilder: (context, index) {
                            final phieu = _filteredPhieu[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: Colors.blue.shade50, // Màu nền nhẹ
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.description,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  phieu.noiDung ?? '---',
                                  maxLines: 2,
                                  overflow: TextOverflow
                                      .ellipsis, // Dấu "..." khi dài quá
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                subtitle: Text(
                                  'Lớp: ${phieu.lopHocPhan?.lop.tenLop ?? '---'} | Môn: ${phieu.lopHocPhan?.tenHocPhan ?? '---'}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: Text(
                                  phieu.ngay ?? '---',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    backgroundColor:
                                        Colors.white, // Màu nền trắng
                                    isScrollControlled: true,
                                    builder: (context) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                        left: 16,
                                        right: 16,
                                        top: 24,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Chi tiết phiếu lên lớp',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Divider(),
                                            const SizedBox(height: 20),

                                            _buildDetailRow(
                                              'Lớp:',
                                              phieu.lopHocPhan?.lop.tenLop,
                                              icon: Icons.class_,
                                            ),

                                            _buildDetailRow(
                                              'Giảng viên:',
                                              phieu
                                                      .lopHocPhan
                                                      ?.gv
                                                      ?.hoSo
                                                      ?.hoTen ??
                                                  "Không có giảng viên",
                                              icon: Icons.people,
                                            ),
                                            _buildDetailRow(
                                              'Môn học:',
                                              phieu.lopHocPhan?.tenHocPhan,
                                              icon: Icons.book,
                                            ),
                                            _buildDetailRow(
                                              'Ngày:',
                                              phieu.ngay,
                                              icon: Icons.calendar_today,
                                            ),
                                            _buildDetailRow(
                                              'Phòng:',
                                              phieu.phong?.ten ??
                                                  "Không có phòng",
                                              icon: Icons.meeting_room,
                                            ),
                                            _buildDetailRow(
                                              'Sĩ số:',
                                              phieu.siSo?.toString(),
                                              icon: Icons.people,
                                            ),
                                            _buildDetailRow(
                                              'Hiện diện:',
                                              phieu.hienDien?.toString(),
                                              icon: Icons.check_circle,
                                            ),
                                            _buildDetailRow(
                                              'Nội dung:',
                                              phieu.noiDung,
                                              icon: Icons.content_copy,
                                            ),

                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }

          if (phieuState is PhieuLenLopError) {
            return Center(child: Text('Lỗi phiếu: ${phieuState.error}'));
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value, {IconData? icon}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Không cần border, không cần shadow
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(icon, color: Colors.blue),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value ?? '---',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
