import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_giay_xac_nhan.dart';

class DocumentRequestListItem extends StatelessWidget {
  final DocumentRequest request;
  final ValueChanged<bool?> onSelected;
  final VoidCallback onConfirm; // Callback cho nút xác nhận riêng lẻ

  const DocumentRequestListItem({
    Key? key,
    required this.request,
    required this.onSelected,
    required this.onConfirm,
    required this.isSelected,
  }) : super(key: key);

  Color _getStatusColor(DocumentRequestStatus status) {
    switch (status) {
      case DocumentRequestStatus.pending:
        return Colors.orange;
      case DocumentRequestStatus.confirmed:
        return Colors.green;
    }
  }

  String _getStatusText(DocumentRequestStatus status) {
    switch (status) {
      case DocumentRequestStatus.pending:
        return 'Chưa xác nhận';
      case DocumentRequestStatus.confirmed:
        return 'Đã xác nhận';
    }
  }

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (request.status == DocumentRequestStatus.pending)
                  Checkbox(
                    value: isSelected,
                    onChanged: onSelected,
                    activeColor: Colors.blueAccent,
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MSSV: ${request.studentCode} - ${request.studentName}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ngày đăng ký: ${DateFormat('dd/MM/yyyy HH:mm').format(request.requestDate)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Loại giấy: ${request.documentName}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Trạng thái:',
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(request.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: _getStatusColor(request.status)),
                  ),
                  child: Text(
                    _getStatusText(request.status),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(request.status),
                    ),
                  ),
                ),
                if (request.status == DocumentRequestStatus.pending)
                  const Spacer(),
                if (request.status == DocumentRequestStatus.pending)
                  ElevatedButton.icon(
                    onPressed: onConfirm,
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Xác nhận'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
