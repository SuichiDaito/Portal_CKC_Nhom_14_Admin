import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';

class ButtonLogOutInUser extends StatefulWidget {
  final String nameButton;
  final Function onPressed;

  const ButtonLogOutInUser({
    super.key,
    required this.nameButton,
    required this.onPressed,
  });

  State<ButtonLogOutInUser> createState() => ButtonLogOut();
}

class ButtonLogOut extends State<ButtonLogOutInUser> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: widget.onPressed(),
      icon: const Icon(Icons.logout),
      label: Text('${widget.nameButton}'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff347433),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
  }
}
