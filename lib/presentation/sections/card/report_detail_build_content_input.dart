import 'package:flutter/material.dart';

class ReportDetailBuildContentInput extends StatelessWidget {
  final String content;
  final ValueChanged<String> onChanged;

  const ReportDetailBuildContentInput({
    super.key,
    required this.content,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text('Nội dung:', style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          maxLines: 5,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Nhập nội dung biên bản...',
          ),
          onChanged: onChanged,
          controller: TextEditingController(text: content),
        ),
      ],
    );
  }
}
