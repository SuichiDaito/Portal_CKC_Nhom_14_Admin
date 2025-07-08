import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bien_bang_shcn_bloc.dart';
import 'package:portal_ckc/bloc/event/bien_bang_shcn_event.dart';

class ApproveBienBanDialog extends StatelessWidget {
  final int bienBanId;

  const ApproveBienBanDialog({super.key, required this.bienBanId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Xác nhận duyệt biên bản'),
      content: const Text('Bạn có chắc muốn duyệt biên bản này không?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            context.read<BienBangShcnBloc>().add(ConfirmBienBan(bienBanId));
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Đang duyệt biên bản...")),
            );
          },
          child: const Text('Duyệt'),
        ),
      ],
    );
  }
}
