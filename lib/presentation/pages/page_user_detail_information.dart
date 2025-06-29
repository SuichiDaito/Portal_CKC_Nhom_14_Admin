import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    SharedPreferences.getInstance().then((prefs) {
      final userId = prefs.getInt('user_id') ?? 0;
      print('🔍 user_id từ SharedPreferences: $userId');
      if (userId != 0) {
        context.read<AdminBloc>().add(FetchAdminDetail(userId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
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
                      ButtonEditInformationInUser(),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonLogOutInUser(
                              nameButton: 'Đăng xuất',
                              onPressed: () {
                                //nope
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: ButtonChangePasswordInUser()),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is AdminError) {
          return Center(child: Text('Lỗi: ${state.message}'));
        } else {
          return const Center(child: Text('Không có dữ liệu'));
        }
      },
    );
  }
}
