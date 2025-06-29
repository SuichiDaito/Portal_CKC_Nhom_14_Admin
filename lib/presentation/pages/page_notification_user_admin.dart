import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/event/lop_event.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';
import 'package:portal_ckc/bloc/state/lop_state.dart';
import 'package:portal_ckc/bloc/state/thong_bao_state.dart';
import 'package:portal_ckc/presentation/sections/card/danh_sach_lop_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageNotificationUserAdmin extends StatefulWidget {
  const PageNotificationUserAdmin({Key? key}) : super(key: key);

  @override
  _PageNotificationUserAdminState createState() =>
      _PageNotificationUserAdminState();
}

class _PageNotificationUserAdminState extends State<PageNotificationUserAdmin> {
  String selectedTab = 'Chưa duyệt';
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndFetch();
    context.read<ThongBaoBloc>().add(FetchThongBaoList());
  }

  Future<void> _loadUserIdAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
    if (userId != null) {
      context.read<ThongBaoBloc>().add(FetchThongBaoList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kho lưu trữ thông báo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocListener<ThongBaoBloc, ThongBaoState>(
        listener: (context, state) {
          if (state is TBSuccess) {
            // Gọi lại API để reload danh sách
            context.read<ThongBaoBloc>().add(FetchThongBaoList());

            // Optional: Hiển thị thông báo nhỏ
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<ThongBaoBloc, ThongBaoState>(
          builder: (context, state) {
            if (state is TBLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TBFailure) {
              return Center(child: Text('Lỗi: ${state.error}'));
            }

            if (state is TBListLoaded && userId != null) {
              final notiList = state.list
                  .where(
                    (e) => e.giangVien != null && e.giangVien!.id == userId,
                  )
                  .where(
                    (e) => selectedTab == 'Đã duyệt'
                        ? e.trangThai == 1
                        : e.trangThai == 0,
                  )
                  .toList();

              return Column(
                children: [
                  _buildTabBar(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: notiList.length,
                      itemBuilder: (_, index) {
                        final tb = notiList[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// 🔹 Tiêu đề
                                Text(
                                  tb.tieuDe,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                /// 🔹 Nội dung rút gọn
                                Text(
                                  tb.noiDung,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: 12),

                                /// 🔹 Thông tin phụ
                                Row(
                                  children: [
                                    const Spacer(),
                                    Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      tb.giangVien?.hoSo?.hoTen ?? 'Người gửi',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.apartment,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      tb.tuAi,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                /// 🔹 Hành động
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (tb.trangThai == 0)
                                      // IconButton(
                                      //   tooltip: 'Đăng',
                                      //   icon: const Icon(
                                      //     Icons.publish,
                                      //     color: Colors.blue,
                                      //   ),
                                      //   onPressed: () {
                                      //     context.read<ThongBaoBloc>().add(
                                      //       UpdateThongBao(
                                      //         id: tb.id,
                                      //         title: tb.tieuDe,
                                      //         content: tb.noiDung,
                                      //         trangThai: 1,
                                      //         tuAi: tb.tuAi,
                                      //       ),
                                      //     );
                                      //     // Gọi lại sau một chút để đảm bảo dữ liệu được cập nhật
                                      //     Future.delayed(
                                      //       const Duration(milliseconds: 300),
                                      //       () {
                                      //         context.read<ThongBaoBloc>().add(
                                      //           FetchThongBaoList(),
                                      //         );
                                      //       },
                                      //     );
                                      //   },
                                      // ),
                                      IconButton(
                                        tooltip: 'Chọn lớp',
                                        icon: const Icon(
                                          Icons.send,
                                          color: Colors.orange,
                                        ),
                                        onPressed: () async {
                                          // Gửi sự kiện lấy danh sách lớp
                                          context.read<LopBloc>().add(
                                            FetchAllLopEvent(),
                                          );

                                          // Mở bottom sheet chọn lớp
                                          final selectedLopIds =
                                              await showModalBottomSheet<
                                                List<int>
                                              >(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (_) =>
                                                    const DanhSachLopSheet(),
                                              );

                                          if (selectedLopIds != null &&
                                              selectedLopIds.isNotEmpty) {
                                            context.read<ThongBaoBloc>().add(
                                              SendToStudents(
                                                tb.id,
                                                selectedLopIds,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    const SizedBox(width: 4),
                                    IconButton(
                                      tooltip: 'Xoá',
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Xác nhận xoá'),
                                            content: const Text(
                                              'Bạn có chắc muốn xoá thông báo này?',
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('Huỷ'),
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  false,
                                                ),
                                              ),
                                              TextButton(
                                                child: const Text('Xoá'),
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          context.read<ThongBaoBloc>().add(
                                            DeleteThongBao(tb.id),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: ['Chưa duyệt', 'Đã duyệt'].map((tab) {
          final isSelected = selectedTab == tab;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = tab),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
