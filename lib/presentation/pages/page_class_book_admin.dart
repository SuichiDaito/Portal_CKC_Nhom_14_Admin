import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageClassBookAdmin extends StatefulWidget {
  const PageClassBookAdmin({super.key});

  @override
  State<PageClassBookAdmin> createState() => _PageClassBookAdminState();
}

class _PageClassBookAdminState extends State<PageClassBookAdmin> {
  String? selectedLop;
  String? selectedMon;
  // final tietTuController = TextEditingController();
  // final tietDenController = TextEditingController();
  // final siSoController = TextEditingController();
  // final hienDienController = TextEditingController();
  final noiDungController = TextEditingController();

  final List<String> danhSachLop = ['CTK45A', 'CTK45B', 'CDT45A'];
  final List<String> danhSachMon = [
    'Lập trình Flutter',
    'CSDL',
    'Kỹ thuật lập trình',
  ];
  double tietTu = 1;
  double tietDen = 2;
  double hienDien = 0;
  final TextEditingController siSoController = TextEditingController(
    text: '30',
  ); // mặc định sĩ số
  final TextEditingController hienDienController = TextEditingController(
    text: '30',
  );

  final TextEditingController tietTuController = TextEditingController(
    text: '1',
  );
  final TextEditingController tietDenController = TextEditingController(
    text: '2',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sổ Lên Lớp", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200, // 🎨 Nền xám nhẹ
            borderRadius: BorderRadius.circular(12), // Bo góc
          ),
          child: Column(
            children: [
              buildDropdownField("Lớp dạy", danhSachLop, selectedLop, (value) {
                setState(() => selectedLop = value);
              }),
              const SizedBox(height: 12),
              buildDropdownField("Môn dạy", danhSachMon, selectedMon, (value) {
                setState(() => selectedMon = value);
              }),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Từ tiết'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  tietTu = (tietTu > 1) ? tietTu - 1 : 1;
                                  tietTuController.text = tietTu
                                      .toInt()
                                      .toString();
                                });
                              },
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: tietTuController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    tietTu = double.tryParse(value) ?? tietTu;
                                  });
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  tietTu = tietTu + 1;
                                  tietTuController.text = tietTu
                                      .toInt()
                                      .toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Đến tiết'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  tietDen = (tietDen > tietTu)
                                      ? tietDen - 1
                                      : tietTu;
                                  tietDenController.text = tietDen
                                      .toInt()
                                      .toString();
                                });
                              },
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: tietDenController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    tietDen = double.tryParse(value) ?? tietDen;
                                  });
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  tietDen = tietDen + 1;
                                  tietDenController.text = tietDen
                                      .toInt()
                                      .toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sĩ số'),
                        TextFormField(
                          controller: siSoController,
                          readOnly: true, // Không cho người dùng nhập tay
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Hiện diện'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  // ✅ Đồng bộ giá trị từ controller nếu người dùng chưa gõ gì
                                  hienDien =
                                      double.tryParse(
                                        hienDienController.text,
                                      ) ??
                                      hienDien;

                                  if (hienDien > 0) {
                                    hienDien -= 1;
                                    hienDienController.text = hienDien
                                        .toInt()
                                        .toString();
                                  }
                                });
                              },
                            ),

                            Expanded(
                              child: TextFormField(
                                controller: hienDienController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                                onChanged: (value) {
                                  final parsed = double.tryParse(value);
                                  if (parsed != null &&
                                      parsed <=
                                          double.parse(siSoController.text)) {
                                    setState(() {
                                      hienDien = parsed;
                                    });
                                  } else {
                                    hienDienController.text = hienDien
                                        .toInt()
                                        .toString();
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  double maxSiSo =
                                      double.tryParse(siSoController.text) ?? 0;
                                  if (hienDien < maxSiSo) {
                                    hienDien++;
                                    hienDienController.text = hienDien
                                        .toInt()
                                        .toString();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              buildTextField(
                "Nội dung giảng dạy",
                noiDungController,
                TextInputType.multiline,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã lưu thông tin.')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white, // chữ trắng
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // góc vuông hơn
                        ),
                      ),
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: const Text("Lưu"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.exit_to_app, color: Colors.white),
                      label: const Text(
                        "Thoát",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField(
    String label,
    List<String> items,
    String? selectedValue,
    void Function(String?) onChanged,
  ) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          onChanged: onChanged,
          items: items
              .map(
                (item) =>
                    DropdownMenuItem<String>(value: item, child: Text(item)),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller,
    TextInputType inputType, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
    );
  }

  @override
  void dispose() {
    tietTuController.dispose();
    tietDenController.dispose();
    siSoController.dispose();
    hienDienController.dispose();
    noiDungController.dispose();
    super.dispose();
  }
}
