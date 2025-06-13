import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:go_router/go_router.dart';

class NienKhoa {
  final int id;
  final String tenNienKhoa;
  final String namBatDau;
  final String namKetThuc;
  final int trangThai;

  NienKhoa({
    required this.id,
    required this.tenNienKhoa,
    required this.namBatDau,
    required this.namKetThuc,
    required this.trangThai,
  });

  factory NienKhoa.fromJson(Map<String, dynamic> json) {
    return NienKhoa(
      id: json['id'],
      tenNienKhoa: json['ten_nien_khoa'],
      namBatDau: json['nam_bat_dau'],
      namKetThuc: json['nam_ket_thuc'],
      trangThai: json['trang_thai'],
    );
  }
}

class NganhHoc {
  final int id;
  final int idKhoa;
  final String tenNganh;

  NganhHoc({required this.id, required this.idKhoa, required this.tenNganh});

  factory NganhHoc.fromJson(Map<String, dynamic> json) {
    return NganhHoc(
      id: json['id'],
      idKhoa: json['id_khoa'],
      tenNganh: json['ten_nganh'],
    );
  }
}

class BoMon {
  final int id;
  final int idNganhHoc;
  final String tenBoMon;
  final NganhHoc nganhHoc;

  BoMon({
    required this.id,
    required this.idNganhHoc,
    required this.tenBoMon,
    required this.nganhHoc,
  });

  factory BoMon.fromJson(Map<String, dynamic> json) {
    return BoMon(
      id: json['id'],
      idNganhHoc: json['id_nganh_hoc'],
      tenBoMon: json['ten_bo_mon'],
      nganhHoc: NganhHoc.fromJson(json['nganh_hoc']),
    );
  }
}

class GiangVien {
  final int id;
  final int idHoSo;
  final int idBoMon;
  final String taiKhoan;
  final int trangThai;
  final BoMon boMon;

  GiangVien({
    required this.id,
    required this.idHoSo,
    required this.idBoMon,
    required this.taiKhoan,
    required this.trangThai,
    required this.boMon,
  });

  factory GiangVien.fromJson(Map<String, dynamic> json) {
    return GiangVien(
      id: json['id'],
      idHoSo: json['id_ho_so'],
      idBoMon: json['id_bo_mon'],
      taiKhoan: json['tai_khoan'],
      trangThai: json['trang_thai'],
      boMon: BoMon.fromJson(json['bo_mon']),
    );
  }
}

class Lop {
  final int id;
  final String tenLop;
  final int idNienKhoa;
  final int idGvcn;
  final int siSo;
  final NienKhoa nienKhoa;
  final GiangVien giangVien;

  Lop({
    required this.id,
    required this.tenLop,
    required this.idNienKhoa,
    required this.idGvcn,
    required this.siSo,
    required this.nienKhoa,
    required this.giangVien,
  });

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'],
      tenLop: json['ten_lop'],
      idNienKhoa: json['id_nien_khoa'],
      idGvcn: json['id_gvcn'],
      siSo: json['si_so'],
      nienKhoa: NienKhoa.fromJson(json['nien_khoa']),
      giangVien: GiangVien.fromJson(json['giang_vien']),
    );
  }

  String get trangThai {
    if (nienKhoa.trangThai == 1) return 'Đang học';
    if (DateTime.now().year > int.parse(nienKhoa.namKetThuc))
      return 'Hoàn thành';
    if (DateTime.now().year < int.parse(nienKhoa.namBatDau)) return 'Chuẩn bị';
    return 'Đang học';
  }
}

class ApiResponse {
  final bool success;
  final List<Lop> lops;
  final List<NienKhoa> nienKhoas;
  final List<NganhHoc> nganhHocs;

  ApiResponse({
    required this.success,
    required this.lops,
    required this.nienKhoas,
    required this.nganhHocs,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      lops: (json['lops'] as List).map((item) => Lop.fromJson(item)).toList(),
      nienKhoas: (json['nien_khoas'] as List)
          .map((item) => NienKhoa.fromJson(item))
          .toList(),
      nganhHocs: (json['nganh_hocs'] as List)
          .map((item) => NganhHoc.fromJson(item))
          .toList(),
    );
  }
}

class PageClassListAdmin extends StatefulWidget {
  @override
  _PageClassListAdminState createState() => _PageClassListAdminState();
}

class _PageClassListAdminState extends State<PageClassListAdmin>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  String selectedNganhFilter = 'Tất cả';
  String selectedNienKhoaFilter = 'Tất cả';
  String selectedBoMonFilter = 'Tất cả';
  String searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  // Sample data từ API
  final String sampleApiData = '''
{
  "success": true,
  "lops": [
    {
  "id": 5,
  "ten_lop": "CD DTCN 23A",
  "id_nien_khoa": 2,
  "id_gvcn": 4,
  "si_so": 45,
  "nien_khoa": {
    "id": 2,
    "ten_nien_khoa": "2023-2026",
    "nam_bat_dau": "2023",
    "nam_ket_thuc": "2026",
    "trang_thai": 1
  },
  "giang_vien": {
    "id": 4,
    "id_ho_so": 10,
    "id_bo_mon": 1,
    "tai_khoan": "gv4",
    "trang_thai": 1,
    "bo_mon": {
      "id": 1,
      "id_nganh_hoc": 1,
      "ten_bo_mon": "Tin Học Phần Cứng",
      "nganh_hoc": {
        "id": 1,
        "id_khoa": 1,
        "ten_nganh": "Tin Học"
      }
    }
  }
}

  ],
  "nien_khoas": [
  {
    "id": 2,
    "ten_nien_khoa": "2023-2026",
    "nam_bat_dau": "2023",
    "nam_ket_thuc": "2026",
    "trang_thai": 1
  },
  {
    "id": 1,
    "ten_nien_khoa": "2022-2025",
    "nam_bat_dau": "2022",
    "nam_ket_thuc": "2025",
    "trang_thai": 0
  }
],
"nganh_hocs": [
  {
    "id": 1,
    "id_khoa": 1,
    "ten_nganh": "Tin Học"
  },
  {
    "id": 2,
    "id_khoa": 1,
    "ten_nganh": "Công Nghệ Kỹ Thuật Điện, Điện Tử"
  }
]

}
''';

  late ApiResponse apiData;
  void _nhapDiem(Lop lop) {
    context.push('/admin/diemrenluyen');

    print("Nhập điểm cho lớp: ${lop.tenLop}");
  }

  void _guiThongBao(Lop lop) {
    // TODO: mở giao diện nhập thông báo hoặc gửi thông báo
    print("Gửi thông báo cho lớp: ${lop.tenLop}");
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Load data từ API
    _loadData();
    _animationController.forward();
  }

  void _loadData() {
    final Map<String, dynamic> jsonData = json.decode(sampleApiData);
    apiData = ApiResponse.fromJson(jsonData);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Lop> get filteredClasses {
    return apiData.lops.where((lop) {
      bool matchesNganh =
          selectedNganhFilter == 'Tất cả' ||
          lop.giangVien.boMon.nganhHoc.tenNganh == selectedNganhFilter;
      bool matchesNienKhoa =
          selectedNienKhoaFilter == 'Tất cả' ||
          lop.nienKhoa.tenNienKhoa == selectedNienKhoaFilter;
      bool matchesBoMon =
          selectedBoMonFilter == 'Tất cả' ||
          lop.giangVien.boMon.tenBoMon == selectedBoMonFilter;
      bool matchesSearch =
          searchQuery.isEmpty ||
          lop.tenLop.toLowerCase().contains(searchQuery.toLowerCase()) ||
          lop.giangVien.boMon.tenBoMon.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );

      return matchesNganh && matchesNienKhoa && matchesBoMon && matchesSearch;
    }).toList();
  }

  List<String> get uniqueNganhs {
    Set<String> nganhs = apiData.lops
        .map((lop) => lop.giangVien.boMon.nganhHoc.tenNganh)
        .toSet();
    return ['Tất cả'] + nganhs.toList();
  }

  List<String> get uniqueNienKhoas {
    Set<String> nienKhoas = apiData.lops
        .map((lop) => lop.nienKhoa.tenNienKhoa)
        .toSet();
    return ['Tất cả'] + nienKhoas.toList();
  }

  List<String> get uniqueBoMons {
    Set<String> boMons = apiData.lops
        .map((lop) => lop.giangVien.boMon.tenBoMon)
        .toSet();
    return ['Tất cả'] + boMons.toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Đang học':
        return Colors.green;
      case 'Hoàn thành':
        return Colors.blue;
      case 'Chuẩn bị':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade50,
              Colors.purple.shade50,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildHeader(),
                _buildFilterSection(),
                Expanded(child: _buildClassList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade600, Colors.purple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.school, color: Colors.white, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quản Lý Lớp Học',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Giảng viên chủ nhiệm',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${filteredClasses.length} lớp',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm lớp học, bộ môn...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedNganhFilter,
                      hint: Text('Ngành học'),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.indigo,
                      ),
                      items: uniqueNganhs.map((String nganh) {
                        return DropdownMenuItem<String>(
                          value: nganh,
                          child: Text(nganh, style: TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedNganhFilter = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedNienKhoaFilter,
                      hint: Text('Niên khóa'),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.indigo,
                      ),
                      items: uniqueNienKhoas.map((String nienKhoa) {
                        return DropdownMenuItem<String>(
                          value: nienKhoa,
                          child: Text(nienKhoa, style: TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedNienKhoaFilter = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedBoMonFilter,
                hint: Text('Bộ môn'),
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.indigo),
                items: uniqueBoMons.map((String boMon) {
                  return DropdownMenuItem<String>(
                    value: boMon,
                    child: Text(boMon, style: TextStyle(fontSize: 13)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBoMonFilter = newValue!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: filteredClasses.length,
        itemBuilder: (context, index) {
          return _buildClassCard(filteredClasses[index], index);
        },
      ),
    );
  }

  Widget _buildClassCard(Lop lop, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    _showClassDetails(lop);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.indigo.shade400,
                                    Colors.purple.shade400,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.class_,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lop.tenLop,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Mã lớp: ${lop.id}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Trạng thái: ${lop.trangThai}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Môn dạy: ${lop.giangVien.boMon.tenBoMon ?? 'Chưa có'}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _nhapDiem(lop);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Nhập điểm rèn luyện",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _guiThongBao(lop);
                                },
                                icon: Icon(Icons.notifications, size: 16),
                                label: Text("Thông báo"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
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
            ),
          ),
        );
      },
    );
  }

  void _showClassDetails(Lop lop) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thông tin lớp'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tên lớp: ${lop.tenLop}'),
              Text('Mã lớp: ${lop.id}'),
              // Thêm các thông tin khác nếu cần
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
