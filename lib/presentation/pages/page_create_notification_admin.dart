import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart'
    show PlatformFile, FilePicker, FileType;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';
import 'package:portal_ckc/bloc/state/thong_bao_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageCreateNotificationAdmin extends StatefulWidget {
  final ThongBao? thongBao;

  const PageCreateNotificationAdmin({Key? key, this.thongBao})
    : super(key: key);

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
  List<PlatformFile> _selectedFiles = [];
  List<FileModel> _apiFiles = [];
  ThongBao? _thongBao;
  double _downloadProgress = 0.0;

  void _downloadFile(FileModel file) async {
    final url =
        'https://ckc-portal.click/api/admin/thongbao/file/download/${file.id}';
    print("⬇️ Bắt đầu tải file: $url");
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không có quyền truy cập bộ nhớ')),
        );
        return;
      }
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception(
          "⚠️ Token không tồn tại. Có thể người dùng chưa đăng nhập.",
        );
      }

      final dir = Directory('/storage/emulated/0/Download');
      final savePath = "${dir.path}/${file.tenFile}";

      final dio = Dio();

      await dio.download(
        url,
        savePath,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/pdf',
            'User-Agent': 'FlutterApp/1.0',
          },

          validateStatus: (status) => status != null && status < 500,
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      setState(() {
        _downloadProgress = 0.0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Đã lưu file: ${file.tenFile}'),
          backgroundColor: Colors.green,
        ),
      );

      await OpenFilex.open(savePath);
    } catch (e) {
      print("❌ Lỗi tải file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Không thể mở file! Vui lòng vào thư mục để xem.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tb = GoRouterState.of(context).extra as ThongBao?;
      if (tb != null) {
        final allowedValues = ['khoa', 'phong_ctct', 'gvcn', 'gvbm'];
        setState(() {
          _thongBao = tb;
          _titleController.text = tb.tieuDe;
          _contentController.text = tb.noiDung;
          _selectedCapTren = allowedValues.contains(tb.tuAi) ? tb.tuAi : 'khoa';
          _apiFiles = tb.files;
        });
      }
    });
  }

  MediaType getMediaTypeFromExtension(String ext) {
    switch (ext.toLowerCase()) {
      case 'pdf':
        return MediaType('application', 'pdf');
      case 'doc':
        return MediaType('application', 'msword');
      case 'docx':
        return MediaType(
          'application',
          'vnd.openxmlformats-officedocument.wordprocessingml.document',
        );
      case 'xls':
        return MediaType('application', 'vnd.ms-excel');
      case 'xlsx':
        return MediaType(
          'application',
          'vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        );
      default:
        return MediaType('application', 'octet-stream');
    }
  }

  Future<List<http.MultipartFile>> convertToMultipartFiles(
    List<PlatformFile> files,
  ) async {
    return files.map((file) {
      if (file.bytes == null) {
        throw Exception("❌ File '${file.name}' không có dữ liệu bytes!");
      }

      final ext = file.extension?.toLowerCase() ?? '';
      final mediaType = getMediaTypeFromExtension(ext);

      print("🔍 Gửi file: ${file.name}");
      print("📎 MIME: $mediaType");

      return http.MultipartFile.fromBytes(
        'files[]',
        file.bytes!,
        filename: file.name,
        contentType: mediaType,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ThongBao? thongBao = GoRouterState.of(context).extra as ThongBao?;
    if (thongBao != null && _titleController.text.isEmpty) {
      _titleController.text = thongBao.tieuDe;
      _contentController.text = thongBao.noiDung;
      _selectedCapTren = thongBao.tuAi;
    }

    final isEditing = thongBao != null;

    return WillPopScope(
      onWillPop: () async {
        context.pop(true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Sửa thông báo' : 'Tạo thông báo'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop(true);
            },
          ),
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
                SnackBar(
                  content: Text("Không thể tạo khi báo! Vui lòng thử lại"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            print(
              "📁 File đính kèm nhận được: ${thongBao?.files.length ?? ""}",
            );
            if (thongBao != null) {
              for (var f in thongBao!.files) {
                print("Tên file: ${f.tenFile} - URL: ${f.url}");
              }
            }

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
                        if (_downloadProgress > 0 && _downloadProgress < 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Đang tải file..."),
                                LinearProgressIndicator(
                                  value: _downloadProgress,
                                ),
                                Text(
                                  "${(_downloadProgress * 100).toStringAsFixed(0)}%",
                                ),
                              ],
                            ),
                          ),

                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Tiêu đề',
                          ),
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
                            DropdownMenuItem(
                              value: 'khoa',
                              child: Text('Khoa'),
                            ),
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
                        if (thongBao?.files.isNotEmpty ?? false)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'File đã đính kèm:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ...thongBao!.files.map(
                                (f) => ListTile(
                                  leading: const Icon(Icons.insert_drive_file),
                                  title: Text(f.tenFile),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.download),
                                        onPressed: () {
                                          _downloadFile(f);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          context.read<ThongBaoBloc>().add(
                                            DeleteAttachedFile(f.id),
                                          );
                                          setState(() {
                                            _apiFiles.removeWhere(
                                              (e) => e.id == f.id,
                                            );
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        if (_selectedFiles.isNotEmpty)
                          ..._selectedFiles.map(
                            (file) => ListTile(
                              leading: const Icon(Icons.insert_drive_file),
                              title: Text(file.name),
                            ),
                          ),
                        const SizedBox(height: 14),

                        ElevatedButton.icon(
                          icon: const Icon(Icons.attach_file),
                          label: const Text('Chọn tệp đính kèm'),
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                              withReadStream: true,
                              withData: true,
                              type: FileType.custom,
                              allowedExtensions: [
                                'doc',
                                'docx',
                                'xls',
                                'xlsx',
                                'pdf',
                              ],
                            );

                            if (result != null) {
                              final invalidFiles = result.files.where((f) {
                                final ext = f.extension?.toLowerCase() ?? '';
                                return ![
                                  'doc',
                                  'docx',
                                  'xls',
                                  'xlsx',
                                  'pdf',
                                ].contains(ext);
                              }).toList();

                              if (invalidFiles.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '❌ Có tệp không hợp lệ, vui lòng chọn lại',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                _selectedFiles.addAll(result.files);
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 14),

                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final formattedNgayGui = DateFormat(
                                "yyyy-MM-dd'T'HH:mm",
                              ).format(_selectedDate.toUtc());

                              final multipartFiles =
                                  await convertToMultipartFiles(_selectedFiles);
                              print("Tiêu đề: ${_titleController.text}");
                              print("Nội dung: ${_contentController.text}");
                              print("Từ ai: $_selectedCapTren");
                              print("Ngày gửi: $formattedNgayGui");

                              final oldFilesJson = jsonEncode(
                                _apiFiles.map((e) => e.id).toList(),
                              );

                              if (isEditing) {
                                final oldFilesIds = _apiFiles
                                    .map((e) => e.id)
                                    .toList();

                                context.read<ThongBaoBloc>().add(
                                  UpdateThongBao(
                                    id: thongBao.id,
                                    ngayGui: formattedNgayGui,
                                    title: _titleController.text,
                                    content: _contentController.text,
                                    trangThai: thongBao.trangThai,
                                    tuAi: _selectedCapTren,
                                    files: multipartFiles,
                                    oldFiles: oldFilesIds,
                                  ),
                                );
                              } else {
                                context.read<ThongBaoBloc>().add(
                                  CreateThongBao(
                                    title: _titleController.text,
                                    content: _contentController.text,
                                    capTren: _selectedCapTren,
                                    ngayGui: formattedNgayGui,
                                    files: multipartFiles,
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
      ),
    );
  }
}
