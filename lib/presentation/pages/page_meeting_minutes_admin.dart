import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BienBanModel {
  final String tenLop;
  final String tenGVCN;
  final String tenThuKy;
  final int tuan;
  final String ngayThang;
  final String trangThai;

  BienBanModel({
    required this.tenLop,
    required this.tenGVCN,
    required this.tenThuKy,
    required this.tuan,
    required this.ngayThang,
    required this.trangThai,
  });
}

//TRANG DANH SÁCH BIÊN BẢNG CHỦ NHIỆM
class PageMeetingMinutesAdmin extends StatefulWidget {
  const PageMeetingMinutesAdmin({super.key});

  @override
  State<PageMeetingMinutesAdmin> createState() =>
      _PageMeetingMinutesAdminState();
}

class _PageMeetingMinutesAdminState extends State<PageMeetingMinutesAdmin> {
  String selectedClass = 'CTK45A';
  String selectedWeek = '1';

  List<String> classes = ['CTK45A', 'CTK45B', 'CTK45C'];
  List<String> weeks = List.generate(20, (i) => '${i + 1}');

  List<BienBanModel> bienBans = [
    BienBanModel(
      tenLop: 'CTK45A',
      tenGVCN: 'Nguyễn Văn A',
      tenThuKy: 'Trần Thị B',
      tuan: 1,
      ngayThang: '03/06/2025',
      trangThai: 'Chờ duyệt',
    ),
    BienBanModel(
      tenLop: 'CTK45A',
      tenGVCN: 'Nguyễn Văn A',
      tenThuKy: 'Trần Thị B',
      tuan: 2,
      ngayThang: '10/06/2025',
      trangThai: 'Đã duyệt',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biên bản chủ nhiệm'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
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
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                ),
              ),
              child: Row(
                children: [
                  const Text('Lớp:', style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedClass,
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Colors.black),
                          iconEnabledColor: Colors.blue,
                          items: classes
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => selectedClass = value!);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text('Tuần:', style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedWeek,
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Colors.black),
                          iconEnabledColor: Colors.blue,
                          items: weeks
                              .map(
                                (w) =>
                                    DropdownMenuItem(value: w, child: Text(w)),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => selectedWeek = value!);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                      '${bienBan.tenLop} - Tuần ${bienBan.tuan}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GVCN: ${bienBan.tenGVCN}'),
                        Text('Thư ký: ${bienBan.tenThuKy}'),
                        Text('Ngày: ${bienBan.ngayThang}'),
                        Text(
                          'Trạng thái: ${bienBan.trangThai}',
                          style: TextStyle(
                            color: bienBan.trangThai == 'Đã duyệt'
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Xử lý xem chi tiết
                        context.push(
                          '/admin/report_detail_admin',
                          extra: {'isApproved': false},
                        );
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
            ),
          ),
        ],
      ),
    );
  }
}
