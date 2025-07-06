import 'package:flutter/material.dart';

class EditScoreDialog extends StatefulWidget {
  final String maSv;
  final Map<String, dynamic> currentScores;

  const EditScoreDialog({
    super.key,
    required this.maSv,
    required this.currentScores,
  });

  @override
  State<EditScoreDialog> createState() => _EditScoreDialogState();
}

class _EditScoreDialogState extends State<EditScoreDialog> {
  late TextEditingController lyThuyetController;
  late TextEditingController thucHanhController;

  @override
  void initState() {
    super.initState();
    lyThuyetController = TextEditingController(
      text: widget.currentScores['lyThuyet']?.toString(),
    );
    thucHanhController = TextEditingController(
      text: widget.currentScores['thucHanh']?.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sửa điểm - ${widget.maSv}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: lyThuyetController,
            decoration: const InputDecoration(labelText: 'Điểm lý thuyết'),
          ),
          TextField(
            controller: thucHanhController,
            decoration: const InputDecoration(labelText: 'Điểm thực hành'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            // Gửi sự kiện cập nhật điểm tại đây
            Navigator.pop(context);
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
