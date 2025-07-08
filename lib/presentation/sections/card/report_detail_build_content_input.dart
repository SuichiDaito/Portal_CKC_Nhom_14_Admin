import 'package:flutter/material.dart';

class ReportDetailBuildContentInput extends StatefulWidget {
  final String content;
  final ValueChanged<String> onChanged;

  const ReportDetailBuildContentInput({
    super.key,
    required this.content,
    required this.onChanged,
  });

  @override
  State<ReportDetailBuildContentInput> createState() =>
      _ReportDetailBuildContentInputState();
}

class _ReportDetailBuildContentInputState
    extends State<ReportDetailBuildContentInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.content);
  }

  @override
  void didUpdateWidget(covariant ReportDetailBuildContentInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Cập nhật nội dung nếu `content` thay đổi từ cha
    if (widget.content != oldWidget.content &&
        widget.content != _controller.text) {
      _controller.text = widget.content;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text('Nội dung:', style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          maxLines: 5,
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Nhập nội dung biên bản...',
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
