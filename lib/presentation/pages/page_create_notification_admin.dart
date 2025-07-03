import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';
import 'package:portal_ckc/bloc/state/thong_bao_state.dart';
import 'package:http/http.dart' show MultipartFile;
import 'package:path/path.dart';

class PageCreateNotificationAdmin extends StatefulWidget {
  const PageCreateNotificationAdmin({super.key});

  @override
  State<PageCreateNotificationAdmin> createState() =>
      _PageCreateNotificationAdminState();
}

class _PageCreateNotificationAdminState
    extends State<PageCreateNotificationAdmin> {
  late BuildContext _buildContext;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedCapTren = 'khoa';

  DateTime _selectedDate = DateTime.now();
  final List<String> _selectedFileNames = [
    'congvan_sinhvien.pdf',
    'thongbao_hethoc.docx',
    'kehoach_giangday.xlsx',
  ];
  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo thông báo'),
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
                        maxLines: 2,
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
                      const SizedBox(height: 16),

                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.attach_file),
                        label: const Text('Chọn file đính kèm'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          backgroundColor: Colors.grey.shade200,
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),

                      if (_selectedFileNames.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _selectedFileNames.map((fileName) {
                              return ListTile(
                                dense: true,
                                leading: const Icon(
                                  Icons.insert_drive_file,
                                  color: Colors.blue,
                                ),
                                title: Text(fileName),
                                subtitle: const Text(
                                  '20.0 KB',
                                  style: TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final now = DateTime.now().toUtc(); // dùng giờ UTC
                            final validNgayGui =
                                _selectedDate.toUtc().isBefore(now)
                                ? _selectedDate.toUtc()
                                : now;

                            final formattedNgayGui = DateFormat(
                              "yyyy-MM-dd'T'HH:mm",
                            ).format(validNgayGui);

                            print('Gửi ngay_gui: $formattedNgayGui');

                            context.read<ThongBaoBloc>().add(
                              CreateThongBao(
                                title: _titleController.text,
                                content: _contentController.text,
                                capTren: _selectedCapTren,
                                ngayGui: formattedNgayGui,
                                files: _selectedFileNames,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('Gửi thông báo'),
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

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: _buildContext,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: _buildContext,
      initialTime: TimeOfDay.fromDateTime(now),
    );

    if (time == null) return;

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

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
