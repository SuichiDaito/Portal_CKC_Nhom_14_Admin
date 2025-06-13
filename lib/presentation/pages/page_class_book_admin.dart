import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageSolenlopAdmin extends StatefulWidget {
  const PageSolenlopAdmin({super.key});

  @override
  State<PageSolenlopAdmin> createState() => _PageSolenlopAdminState();
}

class _PageSolenlopAdminState extends State<PageSolenlopAdmin> {
  final _lopController = TextEditingController();
  final _siSoController = TextEditingController();
  final _noiDungController = TextEditingController();

  String? _monDay;
  String? _tietTu;
  String? _tietDen;

  final List<String> _monList = ['Toán', 'Lý', 'Hóa'];
  final List<String> _tietList = ['1', '2', '3', '4', '5'];

  @override
  void dispose() {
    _lopController.dispose();
    _siSoController.dispose();
    _noiDungController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sổ lên lớp')),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   'Sổ lên lớp',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(height: 16),
                _buildDropdown('Lớp dạy:*', _monList, _monDay, (value) {
                  setState(() => _monDay = value);
                }),

                _buildDropdown('Môn dạy:*', _monList, _monDay, (value) {
                  setState(() => _monDay = value);
                }),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown('Từ tiết:*', _tietList, _tietTu, (
                        value,
                      ) {
                        setState(() => _tietTu = value);
                      }),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDropdown('Đến tiết:*', _tietList, _tietDen, (
                        value,
                      ) {
                        setState(() => _tietDen = value);
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                _buildTextField('Sĩ số:*', _siSoController),
                const SizedBox(height: 12),

                const Text('Nội dung:*'),
                const SizedBox(height: 6),
                TextField(
                  controller: _noiDungController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Tóm tắt nội dung giảng dạy',
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Không bo góc
                          ),
                        ),
                        onPressed: () {
                          //api lưu mật khẩu
                        },
                        child: const Text(
                          'Lưu',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Không bo góc
                          ),
                        ),
                        onPressed: () {
                          context.go('/home');
                        },
                        child: const Text(
                          'Thay đổi mật khẩu',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '',
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selectedValue,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: selectedValue,
          hint: Text('==${label.replaceAll(':*', '')}=='),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
