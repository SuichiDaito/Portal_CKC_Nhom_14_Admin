import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/presentation/sections/button/button_change_password_in_user.dart';
import 'package:portal_ckc/presentation/sections/button/button_edit_information_in_user.dart';
import 'package:portal_ckc/presentation/sections/button/button_log_out_in_user.dart';
import 'package:portal_ckc/presentation/sections/user_infomation_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailInformationPage extends StatefulWidget {
  const UserDetailInformationPage({Key? key}) : super(key: key);

  @override
  State<UserDetailInformationPage> createState() =>
      _UserDetailInformationPageState();
}

class _UserDetailInformationPageState extends State<UserDetailInformationPage> {
  @override
  void initState() {
    super.initState();
    _fetchUserDetail();
  }

  Future<void> _fetchUserDetail() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id') ?? 0;
    if (userId != 0 && context.mounted) {
      context.read<AdminBloc>().add(FetchAdminDetail(userId));
    }
  }

  Future<void> _navigateToChangePassword(int userId) async {
    final result = await context.push('/admin/doimatkhau');
    if (result == true) {
      await _fetchUserDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state is AdminError) {
          final message = state.message.toLowerCase().contains('permission')
              ? 'Bạn không có quyền thực hiện thao tác này.'
              : state.message;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        }
      },
      child: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdminSuccess) {
            final user = state.user;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    child: AccountInfoSection(user: user),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: ButtonLogOutInUser()),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    _navigateToChangePassword(user.id),
                                icon: const Icon(Icons.lock),
                                label: const Text('Đổi mật khẩu'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(color: Colors.blue),
                                  ),
                                  elevation: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }
}
