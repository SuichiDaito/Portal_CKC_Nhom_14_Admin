import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';

class DashboardAdminPage extends StatefulWidget {
  final Widget child;
  const DashboardAdminPage({required this.child, super.key});

  @override
  State<DashboardAdminPage> createState() => _DashboardAdminLayoutState();
}

class _DashboardAdminLayoutState extends State<DashboardAdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        String hoTen = 'Chưa đăng nhập';
        String chucVu = '---';

        if (state is AdminLoaded) {
          hoTen = state.user.hoSo?.hoTen ?? 'Không có tên';
          chucVu = state.user.roles[0].name ?? 'Không có chức vụ';
        }

        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            context.go('/admin/info');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hoTen,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                chucVu,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    /// Menu chính
                    Text(
                      "Main",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 110, 107, 107),
                      ),
                    ),
                    _SidebarItem(
                      icon: Icons.class_, // 🏫 sổ đầu bài / sổ lên lớp
                      title: "Sổ lên lớp",
                      route: '/admin/solenlop',
                    ),
                    _SidebarItem(
                      icon: Icons.list_alt, // 📄 danh sách lớp
                      title: "Xem danh sách lớp",
                      route: '/admin/danhsachlop',
                    ),
                    _SidebarItem(
                      icon: Icons.calendar_today, // 🗓️ lịch tuần
                      title: "Lịch dạy",
                      route: '/admin/lichday',
                    ),
                    _SidebarItem(
                      icon: Icons.groups, // 👥 lớp chủ nhiệm
                      title: "Lớp chủ nhiệm",
                      route: '/admin/lopchunhiem',
                    ),
                    _SidebarItem(
                      icon: Icons.notifications, // 🔔 thông báo
                      title: "Thông báo",
                      route: '/admin/thongbao',
                    ),
                    Text(
                      "Other",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 110, 107, 107),
                      ),
                    ),
                    _SidebarItem(
                      icon: Icons.meeting_room, // 🏢 quản lý phòng học
                      title: "Quản lý phòng học",
                      route: '/admin/quanlyphong',
                    ),
                    _SidebarItem(
                      icon: Icons.school, // 🎓 quản lý sinh viên
                      title: "Quản lý sinh viên",
                      route: '/admin/quanlyphonghoc',
                    ),
                    _SidebarItem(
                      icon: Icons.person_pin, // 👤 quản lý giảng viên
                      title: "Quản lý giảng viên",
                      route: '/admin/quanlygiangvien',
                    ),
                    _SidebarItem(
                      icon: Icons.event_available, // 📅 lịch thi
                      title: "Lịch thi",
                      route: '/admin/lichthi',
                    ),
                    _SidebarItem(
                      icon: Icons.assignment_turned_in, // 🧾 cấp giấy xác nhận
                      title: "Cấp giấy xác nhận",
                      route: '/admin/capgiayxacnhan',
                    ),
                    _SidebarItem(
                      icon: Icons.view_list, // 📚 lớp học phần
                      title: "Quản lý lớp học phần",
                      route: '/admin/lophocphan',
                    ),
                    _SidebarItem(
                      icon: Icons.settings, // ⚙️ cập nhật tham số
                      title: "Cập nhật tham số",
                      route: '/admin/capnhatthamso',
                    ),
                    const Divider(),
                    _SidebarItem(
                      icon: Icons.logout, // 🚪 đăng xuất
                      title: "Đăng xuất",
                      route: '/logout',
                    ),
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hoTen,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                Text(
                  '($chucVu)',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 228, 230, 231),
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Chưa có thông báo nào")),
                  );
                },
              ),
            ],
          ),

          body: widget.child,
        );
      },
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;

  const _SidebarItem({
    required this.title,
    required this.route,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        onPressed: () {
          context.go(route);
          Navigator.of(context).pop();
        },
        child: Row(
          children: [
            Icon(icon, color: Color.fromARGB(255, 88, 144, 90)),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color.fromARGB(255, 88, 144, 90),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageHomeAdminEmpty extends StatelessWidget {
  const PageHomeAdminEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Chào mừng bạn đến với trang Admin"));
  }
}
