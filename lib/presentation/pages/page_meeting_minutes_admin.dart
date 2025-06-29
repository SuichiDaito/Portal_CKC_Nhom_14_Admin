import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/admin_bien_bang_shcn.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bien_bang_shcn_bloc.dart';
import 'package:portal_ckc/bloc/event/bien_bang_shcn_event.dart';
import 'package:portal_ckc/bloc/state/bien_bang_shcn_state.dart';

class PageMeetingMinutesAdmin extends StatefulWidget {
  final Lop lop;

  const PageMeetingMinutesAdmin({super.key, required this.lop});

  @override
  State<PageMeetingMinutesAdmin> createState() =>
      _PageMeetingMinutesAdminState();
}

class _PageMeetingMinutesAdminState extends State<PageMeetingMinutesAdmin> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _loadBienBan();
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void _loadBienBan() {
    context.read<BienBangShcnBloc>().add(FetchBienBan(widget.lop.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biên bản sinh hoạt chủ nhiệm'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: 'Lọc theo ngày',
            onPressed: _pickDate,
          ),
          if (selectedDate != null)
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Bỏ lọc',
              onPressed: () {
                setState(() => selectedDate = null);
              },
            ),
        ],
      ),
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          // ... Thông tin lớp như cũ
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THÔNG TIN LỚP ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Divider(),
                const SizedBox(height: 8),

                Text(
                  'Lớp: ${widget.lop.tenLop}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Niên khóa: ${widget.lop.nienKhoa.tenNienKhoa ?? 'Chưa cập nhật'}',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 8),

                Text(
                  'Sĩ số: ${widget.lop.siSo ?? 'Chưa cập nhật'}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<BienBangShcnBloc, BienBanState>(
              builder: (context, state) {
                if (state is BienBanLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BienBanLoaded) {
                  List<BienBanSHCN> bienBans = state.bienBanList;

                  // 👉 Nếu có ngày được chọn thì lọc theo ngày đó
                  if (selectedDate != null) {
                    bienBans = bienBans.where((bienBan) {
                      return bienBan.thoiGianBatDau.year ==
                              selectedDate!.year &&
                          bienBan.thoiGianBatDau.month == selectedDate!.month &&
                          bienBan.thoiGianBatDau.day == selectedDate!.day;
                    }).toList();
                  }

                  if (bienBans.isEmpty) {
                    return const Center(child: Text('Không có biên bản nào.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: bienBans.length,
                    itemBuilder: (context, index) {
                      final bienBan = bienBans[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blue.shade100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            '${bienBan.lop.tenLop} - ${bienBan.tieuDe}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('GVCN: ${bienBan.gvcn.hoSo?.hoTen ?? ""}'),
                              Text(
                                'Thư ký: ${bienBan.thuky.hoSo?.hoTen ?? ""}',
                              ),
                              Text(
                                'Ngày: ${bienBan.thoiGianBatDau.day}/${bienBan.thoiGianBatDau.month}/${bienBan.thoiGianBatDau.year}',
                              ),
                              Text(
                                'Trạng thái: ${bienBan.trangThai == 0 ? 'Chưa duyệt' : 'Đã duyệt'}',
                                style: TextStyle(
                                  color: bienBan.trangThai == 'Đã duyệt'
                                      ? Colors.orange
                                      : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              final bloc = context.read<BienBangShcnBloc>();
                              final result = await context.push(
                                '/admin/report_detail_admin',
                                extra: {
                                  'bienBanId': bienBan.id,
                                  'lopId': bienBan
                                      .lop
                                      .id, // hoặc lopId mà bạn đang có
                                },
                              );

                              if (result == 'refresh' && mounted) {
                                _loadBienBan();
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1976D2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Chi tiết',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is BienBanError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
