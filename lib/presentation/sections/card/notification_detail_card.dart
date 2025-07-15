import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:portal_ckc/presentation/sections/notification_content_detail.dart';
import 'package:portal_ckc/presentation/sections/notification_footer_detail.dart';
import 'package:portal_ckc/presentation/sections/notification_sender_information_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationDetailCard extends StatefulWidget {
  final String typeNotificationSender;
  final String date;
  final String headerNotification;
  final String contentNotification;
  final String lengthComment;
  final List<Map<String, String>> files;

  const NotificationDetailCard({
    Key? key,
    required this.typeNotificationSender,
    required this.date,
    required this.headerNotification,
    required this.contentNotification,
    required this.lengthComment,
    required this.files,
  }) : super(key: key);

  @override
  State<NotificationDetailCard> createState() => _NotificationDetailCardState();
}

class _NotificationDetailCardState extends State<NotificationDetailCard> {
  double _downloadProgress = 0.0;

  void _downloadFileFromMap(Map<String, dynamic> file) async {
    final id = file['id'];
    if (id == null) {
      print("❌ Không có ID trong file map");
      return;
    }

    final tenFile = file['ten_file'] ?? 'unknown_file';

    final url =
        'https://ckc-portal.click/api/admin/thongbao/file/download/${id}';

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
        throw Exception('Token không tồn tại');
      }

      final dir = Directory('/storage/emulated/0/Download');
      final savePath = "${dir.path}/$tenFile";

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
          validateStatus: (status) => status! < 500,
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
          content: Text('✅ Đã lưu file: $tenFile'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("❌ Lỗi tải file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Không thể tải file! Vui lòng kiểm tra lại.'),
        ),
      );
      return;
    }

    try {
      final result = await OpenFilex.open(
        '/storage/emulated/0/Download/$tenFile',
      );
      if (result.type != ResultType.done) {
        throw Exception(result.message);
      }
    } catch (e) {
      print("❌ Lỗi mở file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã tải xong nhưng không mở được file.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final files = widget.files;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationSenderInformationDetail(
            typeNotificationSender: widget.typeNotificationSender,
            date: widget.date,
          ),
          NotificationContentDetail(
            headerNotification: widget.headerNotification,
            linkImage: '',
            contentNotification: widget.contentNotification,
          ),
          if (_downloadProgress > 0 && _downloadProgress < 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Đang tải file..."),
                  LinearProgressIndicator(value: _downloadProgress),
                  Text("${(_downloadProgress * 100).toStringAsFixed(0)}%"),
                ],
              ),
            ),
          if (files.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'File đính kèm:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  ...files.map(
                    (file) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () => _downloadFileFromMap(file),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.attach_file,
                              size: 20,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                file['ten_file'] ?? '',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          NotificationFooterDetail(lengthComment: widget.lengthComment),
        ],
      ),
    );
  }
}
