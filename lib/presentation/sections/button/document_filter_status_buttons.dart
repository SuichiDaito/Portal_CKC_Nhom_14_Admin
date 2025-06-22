import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_giay_xac_nhan.dart';
import 'package:portal_ckc/presentation/pages/page_document_request_management_admin.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class FilterStatusButtons extends StatelessWidget {
  final DocumentRequestStatus? currentFilter;
  final ValueChanged<DocumentRequestStatus?> onFilterChanged;

  const FilterStatusButtons({
    Key? key,
    required this.currentFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  String _getStatusText(DocumentRequestStatus status) {
    switch (status) {
      case DocumentRequestStatus.pending:
        return 'Chưa xác nhận';
      case DocumentRequestStatus.confirmed:
        return 'Đã xác nhận';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton('Tất cả', null),
          const SizedBox(width: 8),
          _buildFilterButton(
            _getStatusText(DocumentRequestStatus.pending),
            DocumentRequestStatus.pending,
          ),
          const SizedBox(width: 8),
          _buildFilterButton(
            _getStatusText(DocumentRequestStatus.confirmed),
            DocumentRequestStatus.confirmed,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, DocumentRequestStatus? status) {
    final bool isSelected = currentFilter == status;
    return Expanded(
      child: CustomButton(
        text: text,
        onPressed: () => onFilterChanged(status),
        backgroundColor: isSelected ? Colors.blueAccent : Colors.cyan,
        textColor: isSelected ? Colors.white : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
