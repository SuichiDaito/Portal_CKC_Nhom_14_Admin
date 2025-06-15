import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/button_change_password_in_user.dart';
import 'package:portal_ckc/presentation/sections/button/button_edit_information_in_user.dart';
import 'package:portal_ckc/presentation/sections/button/button_log_out_in_user.dart';
import 'package:portal_ckc/presentation/sections/user_infomation_detail.dart';
import 'package:portal_ckc/presentation/sections/user_profile_card_home_admin.dart';

class UserDetailInformationPage extends StatelessWidget {
  const UserDetailInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(children: [AccountInfoSection()]),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ButtonEditInformationInUser(),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: ButtonLogOutInUser()),
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
  }
}
