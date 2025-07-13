import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_giay_xac_nhan.dart';
import 'package:portal_ckc/bloc/bloc_event_state/giay_xac_nhan_bloc.dart';
import 'package:portal_ckc/bloc/event/giay_xac_nhan_event.dart';
import 'package:portal_ckc/bloc/state/giay_xac_nhan_state.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/button/document_filter_status_buttons.dart';
import 'package:portal_ckc/presentation/sections/card/document_request_listItem.dart';

class PageDocumentRequestManagementAdmin extends StatelessWidget {
  const PageDocumentRequestManagementAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DangKyGiayBloc()..add(FetchDangKyGiayEvent()),
      child: const _DocumentRequestBody(),
    );
  }
}

class _DocumentRequestBody extends StatefulWidget {
  const _DocumentRequestBody({Key? key}) : super(key: key);

  @override
  State<_DocumentRequestBody> createState() => _DocumentRequestBodyState();
}

class _DocumentRequestBodyState extends State<_DocumentRequestBody> {
  DocumentRequestStatus? _currentFilter = DocumentRequestStatus.pending;
  final List<String> _selectedRequestIds = [];

  void _toggleSelection(String id, bool selected) {
    setState(() {
      if (selected) {
        _selectedRequestIds.add(id);
      } else {
        _selectedRequestIds.remove(id);
      }
    });
  }

  void _confirmSelectedRequests(BuildContext context) {
    final userId = 1;
    final selectedIds = _selectedRequestIds.map(int.parse).toList();

    if (selectedIds.isNotEmpty) {
      context.read<DangKyGiayBloc>().add(
        ConfirmMultipleGiayXacNhanEvent(
          ids: selectedIds,
          userId: userId,
          trangThai: 1,
        ),
      );

      setState(() {
        _selectedRequestIds.clear();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý cấp giấy tờ'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color.fromARGB(255, 220, 226, 233),
        child: Column(
          children: [
            FilterStatusButtons(
              currentFilter: _currentFilter,
              onFilterChanged: (status) {
                setState(() {
                  _currentFilter = status as DocumentRequestStatus?;
                  _selectedRequestIds.clear();
                });
              },
            ),
            const SizedBox(height: 8),
            if (_currentFilter != DocumentRequestStatus.confirmed)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    text:
                        'Xác nhận (${_selectedRequestIds.length}) yêu cầu đã chọn',
                    onPressed: () => _confirmSelectedRequests(context),
                    backgroundColor: _selectedRequestIds.isNotEmpty
                        ? Colors.blue
                        : const Color.fromARGB(255, 102, 101, 101),
                    isEnabled: _selectedRequestIds.isNotEmpty,
                  ),
                ),
              ),
            Expanded(
              child: BlocBuilder<DangKyGiayBloc, DangKyGiayState>(
                builder: (context, state) {
                  if (state is DangKyGiayLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DangKyGiayLoaded) {
                    final allRequests = state.danhSach
                        .map((e) => DocumentRequest.fromModel(e))
                        .toList();

                    final filteredRequests = _currentFilter == null
                        ? allRequests
                        : allRequests
                              .where((r) => r.status == _currentFilter)
                              .toList();

                    if (filteredRequests.isEmpty) {
                      return Center(
                        child: Text(
                          _currentFilter == DocumentRequestStatus.pending
                              ? 'Không có yêu cầu chưa xác nhận.'
                              : 'Không có yêu cầu đã xác nhận.',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredRequests.length,
                      itemBuilder: (context, index) {
                        final request = filteredRequests[index];
                        return DocumentRequestListItem(
                          request: request,
                          isSelected: _selectedRequestIds.contains(request.id),
                          onSelected: (isSelected) =>
                              _toggleSelection(request.id, isSelected ?? false),
                          onConfirm: () {
                            final userId = 1;
                            context.read<DangKyGiayBloc>().add(
                              ConfirmMultipleGiayXacNhanEvent(
                                ids: [int.parse(request.id)],
                                userId: userId,
                                trangThai: 1,
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is DangKyGiayError) {
                    return Center(
                      child: Text('Bạn không có quyền truy cập chức năng này'),
                    );
                  } else {
                    return const Center(child: Text('Không có dữ liệu.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
