import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';
import 'package:portal_ckc/bloc/state/thong_bao_state.dart';

class PageCreateNotificationAdmin extends StatefulWidget {
  const PageCreateNotificationAdmin({super.key});

  @override
  State<PageCreateNotificationAdmin> createState() =>
      _PageCreateNotificationAdminState();
}

class _PageCreateNotificationAdminState
    extends State<PageCreateNotificationAdmin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedCapTren = 'khoa';
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Nhận thông báo truyền vào (nếu có)
    final ThongBao? thongBao = GoRouterState.of(context).extra as ThongBao?;

    // Nếu là sửa thì gán giá trị cũ
    if (thongBao != null && _titleController.text.isEmpty) {
      _titleController.text = thongBao.tieuDe;
      _contentController.text = thongBao.noiDung;
      _selectedCapTren = thongBao.tuAi;
    }

    final isEditing = thongBao != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Sửa thông báo' : 'Tạo thông báo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<ThongBaoBloc, ThongBaoState>(
        listener: (context, state) {
          if (state is TBSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.pop(true);
          } else if (state is TBFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Tiêu đề'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Vui lòng nhập tiêu đề'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _contentController,
                        decoration: const InputDecoration(
                          labelText: 'Nội dung',
                        ),
                        maxLines: 3,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Vui lòng nhập nội dung'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedCapTren,
                        decoration: const InputDecoration(labelText: 'Từ ai'),
                        items: const [
                          DropdownMenuItem(value: 'khoa', child: Text('Khoa')),
                          DropdownMenuItem(
                            value: 'phong_ctct',
                            child: Text('Phòng Công Tác Chính Trị'),
                          ),
                          DropdownMenuItem(
                            value: 'gvcn',
                            child: Text('Giáo viên chủ nhiệm'),
                          ),
                          DropdownMenuItem(
                            value: 'gvbm',
                            child: Text('Giáo viên bộ môn'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCapTren = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final now = DateTime.now();
                          final date = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: DateTime(now.year - 1),
                            lastDate: DateTime(now.year + 1),
                          );

                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(now),
                            );

                            if (time != null) {
                              setState(() {
                                _selectedDate = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  time.hour,
                                  time.minute,
                                );
                              });
                            }
                          }
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text(
                          'Chọn ngày gửi: ${DateFormat('dd/MM/yyyy HH:mm').format(_selectedDate)}',
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final formattedNgayGui = DateFormat(
                              "yyyy-MM-dd'T'HH:mm",
                            ).format(_selectedDate.toUtc());

                            if (isEditing) {
                              context.read<ThongBaoBloc>().add(
                                UpdateThongBao(
                                  id: thongBao.id,
                                  ngayGui: formattedNgayGui,
                                  title: _titleController.text,
                                  content: _contentController.text,
                                  trangThai: thongBao.trangThai,
                                  tuAi: _selectedCapTren,
                                ),
                              );
                            } else {
                              context.read<ThongBaoBloc>().add(
                                CreateThongBao(
                                  title: _titleController.text,
                                  content: _contentController.text,
                                  capTren: _selectedCapTren,
                                  ngayGui: formattedNgayGui,
                                  files: const [],
                                ),
                              );
                            }
                          }
                        },
                        icon: Icon(isEditing ? Icons.save : Icons.send),
                        label: Text(
                          isEditing ? 'Cập nhật thông báo' : 'Gửi thông báo',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
