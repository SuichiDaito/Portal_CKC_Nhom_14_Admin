// screens/class_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/lop_hoc_phan_state.dart';
import 'package:portal_ckc/presentation/sections/card/class_roster_class_item_card.dart';
import 'package:portal_ckc/presentation/sections/card/class_roster_teacher_info_card.dart';
import 'package:portal_ckc/presentation/sections/class_roster_filter_section.dart';

class PageClassRosterAdmin extends StatefulWidget {
  const PageClassRosterAdmin({Key? key}) : super(key: key);

  @override
  State<PageClassRosterAdmin> createState() => _PageClassRosterAdminState();
}

class _PageClassRosterAdminState extends State<PageClassRosterAdmin> {
  List<LopHocPhan> allClasses = [];
  List<LopHocPhan> filteredClasses = [];
  String? selectedSubject;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    context.read<LopHocPhanBloc>().add(FetchLopHocPhan());
  }

  void _applyFilters() {
    setState(() {
      filteredClasses = allClasses.where((lop) {
        bool matchesSubject =
            selectedSubject == null || lop.tenHocPhan == selectedSubject;
        bool matchesStatus =
            selectedStatus == null || lop.trangThaiText == selectedStatus;
        return matchesSubject && matchesStatus;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      selectedSubject = null;
      selectedStatus = null;
      filteredClasses = allClasses;
    });
  }

  // void _onClassTap(LopHocPhan lop) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Chi tiết lớp ${lop.lop?.tenLop ?? ''}'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Môn: ${lop.tenHocPhan}'),
  //           Text('Trạng thái: ${lop.trangThaiText}'),
  //           Text('Số SV ĐK: ${lop.soLuongDangKy}'),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Đóng'),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Đóng'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        title: const Text(
          'Lớp học phần',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: BlocBuilder<LopHocPhanBloc, LopHocPhanState>(
        builder: (context, state) {
          if (state is LopHocPhanLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LopHocPhanError) {
            return Center(child: Text('Lỗi: ${state.message}'));
          }
          if (state is LopHocPhanLoaded) {
            allClasses = state.lopHocPhans;
            filteredClasses = allClasses;

            final uniqueSubjects = allClasses
                .map((c) => c.tenHocPhan)
                .toSet()
                .toList();
            final uniqueStatuses = allClasses
                .map((c) => c.trangThaiText)
                .toSet()
                .toList();

            return RefreshIndicator(
              onRefresh: () async {
                context.read<LopHocPhanBloc>().add(FetchLopHocPhan());
              },
              child: CustomScrollView(
                slivers: [
                  // Filter Section
                  SliverToBoxAdapter(
                    child: FilterSection(
                      subjects: uniqueSubjects,
                      statuses: uniqueStatuses,
                      selectedSubject: selectedSubject,
                      selectedStatus: selectedStatus,
                      onSubjectChanged: (value) {
                        selectedSubject = value;
                        _applyFilters();
                      },
                      onStatusChanged: (value) {
                        selectedStatus = value;
                        _applyFilters();
                      },
                      onClearFilters: _clearFilters,
                    ),
                  ),

                  // Class Count
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        'Tìm thấy ${filteredClasses.length} lớp học phần',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  // Class List
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final lop = filteredClasses[index];
                      return ClassItemCard(
                        onTap: () => context.push(
                          '/admin/course_student_list/${lop.id}',
                        ),

                        classModel: lop,
                      );
                    }, childCount: filteredClasses.length),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            );
          }

          return const Center(child: Text('Không có dữ liệu'));
        },
      ),
    );
  }
}

extension TrangThaiText on LopHocPhan {
  String get trangThaiText {
    switch (trangThai) {
      case 0:
        return 'Chưa diễn ra';
      case 1:
        return 'Đang diễn ra';
      case 2:
        return 'Đã kết thúc';
      default:
        return 'Không xác định';
    }
  }
}
