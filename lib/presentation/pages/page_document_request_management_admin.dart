import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/button/document_filter_status_buttons.dart';
import 'package:portal_ckc/presentation/sections/card/document_request_listItem.dart';

enum DocumentRequestStatus { pending, confirmed }

enum DocumentType { transcript, certificate, recommendationLetter, other }

class DocumentRequest {
  final String id; // ID duy nhất của yêu cầu
  final String studentCode; // Mã số sinh viên yêu cầu
  final String studentName; // Tên sinh viên yêu cầu
  final DateTime requestDate; // Ngày đăng ký
  final DocumentType documentType; // Loại giấy
  DocumentRequestStatus status; // Trạng thái
  bool isSelectedForAction; // Dùng cho chức năng chọn nhiều

  DocumentRequest({
    required this.id,
    required this.studentCode,
    required this.studentName,
    required this.requestDate,
    required this.documentType,
    this.status = DocumentRequestStatus.pending,
    this.isSelectedForAction = false,
  });

  // Helper để tạo bản sao khi cập nhật trạng thái hoặc chọn
  DocumentRequest copyWith({
    String? id,
    String? studentCode,
    String? studentName,
    DateTime? requestDate,
    DocumentType? documentType,
    DocumentRequestStatus? status,
    bool? isSelectedForAction,
  }) {
    return DocumentRequest(
      id: id ?? this.id,
      studentCode: studentCode ?? this.studentCode,
      studentName: studentName ?? this.studentName,
      requestDate: requestDate ?? this.requestDate,
      documentType: documentType ?? this.documentType,
      status: status ?? this.status,
      isSelectedForAction: isSelectedForAction ?? this.isSelectedForAction,
    );
  }
}

class PageDocumentRequestManagementAdmin extends StatefulWidget {
  const PageDocumentRequestManagementAdmin({Key? key}) : super(key: key);

  @override
  _PageDocumentRequestManagementAdminState createState() =>
      _PageDocumentRequestManagementAdminState();
}

class _PageDocumentRequestManagementAdminState
    extends State<PageDocumentRequestManagementAdmin> {
  // Dữ liệu giả định
  final List<DocumentRequest> _allRequests = [
    DocumentRequest(
      id: 'REQ001',
      studentCode: 'SV001',
      studentName: 'Nguyễn Văn A',
      requestDate: DateTime(2025, 6, 15, 10, 30),
      documentType: DocumentType.transcript,
      status: DocumentRequestStatus.pending,
    ),
    DocumentRequest(
      id: 'REQ002',
      studentCode: 'SV002',
      studentName: 'Trần Thị B',
      requestDate: DateTime(2025, 6, 14, 14, 0),
      documentType: DocumentType.certificate,
      status: DocumentRequestStatus.confirmed,
    ),
    DocumentRequest(
      id: 'REQ003',
      studentCode: 'SV003',
      studentName: 'Lê Văn C',
      requestDate: DateTime(2025, 6, 13, 9, 15),
      documentType: DocumentType.recommendationLetter,
      status: DocumentRequestStatus.pending,
    ),
    DocumentRequest(
      id: 'REQ004',
      studentCode: 'SV004',
      studentName: 'Phạm Thị D',
      requestDate: DateTime(2025, 6, 12, 11, 45),
      documentType: DocumentType.other,
      status: DocumentRequestStatus.pending,
    ),
    DocumentRequest(
      id: 'REQ005',
      studentCode: 'SV005',
      studentName: 'Hoàng Văn E',
      requestDate: DateTime(2025, 6, 11, 16, 20),
      documentType: DocumentType.transcript,
      status: DocumentRequestStatus.confirmed,
    ),
  ];

  DocumentRequestStatus? _currentFilter =
      DocumentRequestStatus.pending; // Mặc định hiển thị "Chưa xác nhận"

  // Danh sách các yêu cầu đang được chọn để thực hiện hành động hàng loạt
  List<DocumentRequest> _selectedRequests = [];

  // Getter để lấy danh sách các yêu cầu đã lọc
  List<DocumentRequest> get _filteredRequests {
    if (_currentFilter == null) {
      return _allRequests;
    } else {
      return _allRequests.where((req) => req.status == _currentFilter).toList();
    }
  }

  void _updateRequestStatus(String requestId, DocumentRequestStatus newStatus) {
    setState(() {
      final index = _allRequests.indexWhere((req) => req.id == requestId);
      if (index != -1) {
        _allRequests[index] = _allRequests[index].copyWith(
          status: newStatus,
          isSelectedForAction: false,
        );
      }
      _selectedRequests.removeWhere(
        (req) => req.id == requestId,
      ); // Xóa khỏi danh sách đã chọn
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã xác nhận yêu cầu giấy tờ thành công!')),
    );
  }

  void _toggleRequestSelection(String requestId, bool? isSelected) {
    setState(() {
      final index = _allRequests.indexWhere((req) => req.id == requestId);
      if (index != -1) {
        _allRequests[index] = _allRequests[index].copyWith(
          isSelectedForAction: isSelected,
        );
        if (isSelected == true) {
          _selectedRequests.add(_allRequests[index]);
        } else {
          _selectedRequests.removeWhere((req) => req.id == requestId);
        }
      }
    });
  }

  void _confirmSelectedRequests() {
    if (_selectedRequests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn ít nhất một yêu cầu để xác nhận.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận yêu cầu'),
        content: Text(
          'Bạn có chắc chắn muốn xác nhận ${_selectedRequests.length} yêu cầu đã chọn không?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              for (var req in List<DocumentRequest>.from(_selectedRequests)) {
                _updateRequestStatus(req.id, DocumentRequestStatus.confirmed);
              }
              _selectedRequests.clear(); // xóa sau khi lặp xong
              Navigator.pop(context); // Đóng dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Đã xác nhận ${_selectedRequests.length} yêu cầu được chọn.',
                  ),
                ),
              );
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý cấp giấy tờ'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color.fromARGB(255, 167, 215, 239), // 🔵 đổi màu nền ở đây
        child: Column(
          children: [
            // Các nút lọc theo trạng thái
            FilterStatusButtons(
              currentFilter: _currentFilter,
              onFilterChanged: (status) {
                setState(() {
                  _currentFilter = status;
                  // Khi thay đổi bộ lọc, bỏ chọn tất cả các yêu cầu đã chọn trước đó
                  for (var req in _allRequests) {
                    req.isSelectedForAction = false;
                  }
                  _selectedRequests.clear();
                });
              },
            ),
            const SizedBox(height: 8),
            // Nút xác nhận hàng loạt
            if (_currentFilter ==
                DocumentRequestStatus
                    .pending) // Chỉ hiện khi đang ở trạng thái "Chưa xác nhận"
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    text:
                        'Xác nhận (${_selectedRequests.length}) yêu cầu đã chọn',
                    onPressed: _confirmSelectedRequests,
                    backgroundColor: _selectedRequests.isNotEmpty
                        ? Colors.blue
                        : Colors.grey, // Vô hiệu hóa nếu không có gì được chọn
                    isEnabled: _selectedRequests.isNotEmpty,
                  ),
                ),
              ),
            // Danh sách yêu cầu cấp giấy tờ
            Expanded(
              child: _filteredRequests.isEmpty
                  ? Center(
                      child: Text(
                        _currentFilter == DocumentRequestStatus.pending
                            ? 'Không có yêu cầu chưa xác nhận.'
                            : 'Không có yêu cầu đã xác nhận.',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredRequests.length,
                      itemBuilder: (context, index) {
                        final request = _filteredRequests[index];
                        return DocumentRequestListItem(
                          request: request,
                          onSelected: (isSelected) {
                            _toggleRequestSelection(request.id, isSelected);
                          },
                          onConfirm: () {
                            _updateRequestStatus(
                              request.id,
                              DocumentRequestStatus.confirmed,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
