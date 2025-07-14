import 'package:flutter/material.dart';

class PageQuanlyphongAdmin extends StatefulWidget {
  const PageQuanlyphongAdmin({Key? key}) : super(key: key);

  @override
  State<PageQuanlyphongAdmin> createState() => _PageQuanlyphongAdminState();
}

class _PageQuanlyphongAdminState extends State<PageQuanlyphongAdmin> {
  final List<bool> isChecked = List.generate(10, (_) => false);

  void _showBottomSheetThemPhong() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextField(
                decoration: InputDecoration(labelText: 'Tên phòng'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Số lượng chứa'),
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem(
                    value: '${(index + 1) * 10}',
                    child: Text('${(index + 1) * 10} người'),
                  ),
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Loại phòng'),
                items: const [
                  DropdownMenuItem(value: 'LT', child: Text('Lý thuyết')),
                  DropdownMenuItem(value: 'TH', child: Text('Thực hành')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Thêm Phòng'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Quay lại'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý phòng học')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Tạm khóa phòng'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _showBottomSheetThemPhong,
                  child: const Text('Thêm phòng học'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('TT')),
                  DataColumn(label: Text('Tên phòng')),
                  DataColumn(label: Text('Trạng thái')),
                  DataColumn(label: Text('...')),
                ],
                rows: List<DataRow>.generate(
                  isChecked.length,
                  (index) => DataRow(
                    selected: isChecked[index],
                    cells: [
                      DataCell(
                        Checkbox(
                          value: isChecked[index],
                          onChanged: (value) {
                            setState(() {
                              isChecked[index] = value ?? false;
                            });
                          },
                        ),
                      ),
                      DataCell(Text('${index + 1}')),
                      const DataCell(Text('Phòng A')),
                      const DataCell(Text('Đang hoạt động')),
                      const DataCell(Text('...')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
