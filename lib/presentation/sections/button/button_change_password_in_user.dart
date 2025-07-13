import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';

class ButtonChangePasswordInUser extends StatelessWidget {
  @override
  final int userId;

  const ButtonChangePasswordInUser(this.userId, {super.key});

  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final result = await context.push('/admin/doimatkhau');
        if (result == true && context.mounted) {
          context.read<AdminBloc>().add(FetchAdminDetail(userId));
        }
      },
      icon: const Icon(Icons.lock),
      label: const Text('Đổi mật khẩu'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.blue),
        ),
        elevation: 2,
      ),
    );
  }
}
