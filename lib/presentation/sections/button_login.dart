import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portal_ckc/constant/style_of_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLogin extends StatefulWidget {
  final VoidCallback onPressed;
  final String nameButton;

  const ButtonLogin({
    super.key,
    required this.nameButton,
    required this.onPressed,
  });

  @override
  State<ButtonLogin> createState() => _ButtonLogin();
}

class _ButtonLogin extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPressed(),
      child: Text(
        widget.nameButton,
        style: StyleOfWidget.textStyle1(
          fs: 16.sp,
          fw: FontWeight.bold,
          clr: Colors.black,
        ),
      ),
    );
  }
}
