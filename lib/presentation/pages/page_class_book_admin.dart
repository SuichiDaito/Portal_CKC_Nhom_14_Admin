import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_phong.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phieu_len_lop_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phong_bloc.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/event/phieu_len_lop_event.dart';
import 'package:portal_ckc/bloc/event/phong_event.dart';
import 'package:portal_ckc/bloc/state/lop_hoc_phan_state.dart';
import 'package:portal_ckc/bloc/state/phieu_len_lop_state.dart';
import 'package:portal_ckc/bloc/state/phong_state.dart';
import 'package:portal_ckc/presentation/sections/button/action_button.dart';
import 'package:portal_ckc/presentation/sections/card/class_book_common_dropdown_field.dart';
import 'package:portal_ckc/presentation/sections/card/class_book_si_so_section.dart';
import 'package:portal_ckc/presentation/sections/card/class_book_tiet_row_section.dart';
import 'package:portal_ckc/presentation/sections/card/custom_text_field.dart';

class PageClassBookAdmin extends StatefulWidget {
  const PageClassBookAdmin({super.key});

  @override
  State<PageClassBookAdmin> createState() => _PageClassBookAdminState();
}

class _PageClassBookAdminState extends State<PageClassBookAdmin> {
  String? selectedLop;
  String? selectedMon;
  int? selectedLopHocPhanId;
  int? selectedPhongId;

  String? selectedPhong;
  List<String> danhSachPhong = ['Phòng A1', 'Phòng B2', 'Phòng C3']; // ví dụ
  List<Room> allRooms = [];
  final TextEditingController noiDungController = TextEditingController();
  final TextEditingController tietTuController = TextEditingController(
    text: '1',
  );
  final TextEditingController tietDenController = TextEditingController(
    text: '2',
  );
  final TextEditingController siSoController = TextEditingController(
    text: '30',
  );
  final TextEditingController hienDienController = TextEditingController(
    text: '30',
  );

  double tietTu = 1;
  double tietDen = 2;
  double hienDien = 30;

  List<LopHocPhan> allLopHocPhan = [];
  List<String> danhSachLop = [];
  List<String> danhSachMon = [];

  @override
  void initState() {
    super.initState();
    context.read<LopHocPhanBloc>().add(FetchLopHocPhan()); // BẮT BUỘC PHẢI CÓ
    context.read<PhongBloc>().add(FetchRoomsEvent()); // BẮT BUỘC PHẢI CÓ
  }

  void updateMonTheoLop(String? tenLop) {
    if (tenLop == null) return;
    final filtered = allLopHocPhan.where((lhp) => lhp.lop.tenLop == tenLop);
    final monSet = <String>{};
    for (var lhp in filtered) {
      monSet.add(lhp.tenHocPhan);
    }

    setState(() {
      danhSachMon = monSet.toList();
      selectedMon = null;
      selectedLopHocPhanId = null;
    });
  }

  void autoFillFields(String? mon) {
    if (mon == null || selectedLop == null) return;

    LopHocPhan? lhp;

    try {
      lhp = allLopHocPhan.firstWhere(
        (item) => item.tenHocPhan == mon && item.lop.tenLop == selectedLop,
      );
    } catch (_) {
      lhp = null;
    }

    if (lhp == null) return;

    setState(() {
      siSoController.text = lhp!.soLuongDangKy.toString();
      hienDienController.text = lhp.soLuongDangKy.toString();
      hienDien = lhp.soLuongDangKy.toDouble();
      selectedLopHocPhanId = lhp.id;
    });
  }

  void savePhieu() {
    if (selectedLopHocPhanId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Vui lòng chọn lớp và môn")));
      return;
    }

    final payload = {
      "id_lop_hoc_phan": selectedLopHocPhanId,
      "tiet_bat_dau": int.tryParse(tietTuController.text),
      "so_tiet":
          (int.tryParse(tietDenController.text) ?? 0) -
          (int.tryParse(tietTuController.text) ?? 0) +
          1,
      "ngay": DateTime.now().toIso8601String().split('T')[0],
      "id_phong": selectedPhongId,
      "si_so": int.tryParse(siSoController.text),
      "hien_dien": int.tryParse(hienDienController.text),
      "noi_dung": noiDungController.text,
    };

    debugPrint("📤 Gửi tạo phiếu: $payload");
    context.read<PhieuLenLopBloc>().add(CreatePhieuLenLop(payload));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhieuLenLopBloc, PhieuLenLopState>(
      listener: (context, state) {
        if (state is PhieuLenLopSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pop(context);
        } else if (state is PhieuLenLopError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("❌ ${state.error}")));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text(
            "Sổ Lên Lớp",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<PhongBloc, PhongState>(
          builder: (context, phongState) {
            if (phongState is PhongLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (phongState is PhongError) {
              return Center(
                child: Text("Lỗi tải phòng: ${phongState.message}"),
              );
            }

            if (phongState is PhongLoaded) {
              allRooms = phongState.rooms;
              final danhSachPhong = allRooms.map((e) => e.ten).toList();

              return BlocBuilder<LopHocPhanBloc, LopHocPhanState>(
                builder: (context, state) {
                  if (state is LopHocPhanLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is LopHocPhanError) {
                    return Center(child: Text("Lỗi: ${state.message}"));
                  }

                  if (state is LopHocPhanLoaded) {
                    allLopHocPhan = state.lopHocPhans;
                    final lopSet = <String>{};
                    for (var lhp in allLopHocPhan) {
                      lopSet.add(lhp.lop.tenLop);
                    }
                    danhSachLop = lopSet.toList();

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CommonDropdownField(
                                label: "Lớp dạy",
                                items: danhSachLop,
                                selectedValue: selectedLop,
                                onChanged: (value) {
                                  setState(() {
                                    selectedLop = value;
                                    updateMonTheoLop(value);
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              CommonDropdownField(
                                label: "Môn dạy",
                                items: danhSachMon,
                                selectedValue: selectedMon,
                                onChanged: (value) {
                                  setState(() {
                                    selectedMon = value;
                                    autoFillFields(value);
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              CommonDropdownField(
                                label: "Phòng học",
                                items:
                                    danhSachPhong, // danh sách ['Phòng A1', 'Phòng B2', ...]
                                selectedValue: selectedPhong,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPhong = value;

                                    // 🔍 Tìm Room theo tên để lấy ID
                                    final selectedRoom = allRooms.firstWhere(
                                      (room) => room.ten == value,
                                      orElse: () => Room(
                                        id: 0,
                                        ten: '',
                                        soLuong: 0,
                                        loaiPhong: 0,
                                      ),
                                    );
                                    selectedPhongId = selectedRoom.id;
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              TietRowSection(
                                tietTuController: tietTuController,
                                tietDenController: tietDenController,
                                onTietTuMinus: () {
                                  setState(() {
                                    tietTu = (tietTu > 1) ? tietTu - 1 : 1;
                                    tietTuController.text = tietTu
                                        .toInt()
                                        .toString();
                                  });
                                },
                                onTietTuPlus: () {
                                  setState(() {
                                    tietTu += 1;
                                    tietTuController.text = tietTu
                                        .toInt()
                                        .toString();
                                  });
                                },
                                onTietDenMinus: () {
                                  setState(() {
                                    tietDen = (tietDen > tietTu)
                                        ? tietDen - 1
                                        : tietTu;
                                    tietDenController.text = tietDen
                                        .toInt()
                                        .toString();
                                  });
                                },
                                onTietDenPlus: () {
                                  setState(() {
                                    tietDen += 1;
                                    tietDenController.text = tietDen
                                        .toInt()
                                        .toString();
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              SiSoRowSection(
                                siSoController: siSoController,
                                hienDienController: hienDienController,
                                onHienDienMinus: () {
                                  setState(() {
                                    if (hienDien > 0) {
                                      hienDien -= 1;
                                      hienDienController.text = hienDien
                                          .toInt()
                                          .toString();
                                    }
                                  });
                                },
                                onHienDienPlus: () {
                                  setState(() {
                                    double maxSiSo =
                                        double.tryParse(siSoController.text) ??
                                        0;
                                    if (hienDien < maxSiSo) {
                                      hienDien++;
                                      hienDienController.text = hienDien
                                          .toInt()
                                          .toString();
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              CustomTextField(
                                label: "Nội dung giảng dạy",
                                controller: noiDungController,
                                inputType: TextInputType.multiline,
                                maxLines: 4,
                              ),
                              const SizedBox(height: 20),
                              ActionButtons(
                                onSave: savePhieu,
                                onExit: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return const SizedBox(); // fallback cho LopHocPhanState
                },
              );
            }

            return const SizedBox(); // ✅ fallback cho PhongState
          },
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
