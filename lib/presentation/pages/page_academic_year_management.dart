import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/year_filter_status_buttons.dart';
import 'package:portal_ckc/presentation/sections/card/academic_year_list_item.dart';
import 'package:portal_ckc/presentation/sections/card/create_academic_year_bottom_sheet.dart';

enum AcademicYearStatus { initialized, notInitialized }

enum AcademicTerm {
  term1,
  term2,
  summerTerm,
} // Học kỳ: Học kỳ 1, Học kỳ 2, Học kỳ hè

class AcademicYear {
  final String id; // ID duy nhất của năm học/học kỳ
  final String cohort; // Niên khóa (ví dụ: K20, K21)
  final AcademicTerm term; // Học kỳ
  final int year; // Năm học
  final DateTime? startDate; // ✅ nullable
  AcademicYearStatus status; // Trạng thái: Đã khởi tạo / Chưa khởi tạo

  AcademicYear({
    required this.id,
    required this.cohort,
    required this.term,
    required this.year,
    required this.startDate,
    this.status = AcademicYearStatus.notInitialized,
  });

  // Helper để tạo bản sao khi cập nhật trạng thái
  AcademicYear copyWith({
    String? id,
    String? cohort,
    AcademicTerm? term,
    int? year,
    DateTime? startDate,
    AcademicYearStatus? status,
  }) {
    return AcademicYear(
      id: id ?? this.id,
      cohort: cohort ?? this.cohort,
      term: term ?? this.term,
      year: year ?? this.year,
      startDate: startDate ?? this.startDate,
      status: status ?? this.status,
    );
  }
}

class PageAcademicYearManagement extends StatefulWidget {
  const PageAcademicYearManagement({Key? key}) : super(key: key);

  @override
  _PageAcademicYearManagementState createState() =>
      _PageAcademicYearManagementState();
}

class _PageAcademicYearManagementState
    extends State<PageAcademicYearManagement> {
  // Dữ liệu giả định
  final List<AcademicYear> _academicYears = [
    AcademicYear(
      id: 'AY001',
      cohort: 'K20',
      term: AcademicTerm.term1,
      year: 2023,
      startDate: DateTime(2023, 9, 5),
      status: AcademicYearStatus.initialized,
    ),
    AcademicYear(
      id: 'AY002',
      cohort: 'K20',
      term: AcademicTerm.term2,
      year: 2024,
      startDate: DateTime(2024, 1, 15),
      status: AcademicYearStatus.initialized,
    ),
    AcademicYear(
      id: 'AY003',
      cohort: 'K21',
      term: AcademicTerm.term1,
      year: 2024,
      startDate: null,
      status: AcademicYearStatus.notInitialized,
    ),
    AcademicYear(
      id: 'AY004',
      cohort: 'K21',
      term: AcademicTerm.term2,
      year: 2025,
      startDate: null,
      status: AcademicYearStatus.notInitialized,
    ),
  ];

  AcademicYearStatus? _currentFilter = null; // Mặc định hiển thị "Tất cả"

  // Getter để lấy danh sách các năm học/học kỳ đã lọc
  List<AcademicYear> get _filteredAcademicYears {
    if (_currentFilter == null) {
      return _academicYears;
    } else {
      return _academicYears.where((ay) => ay.status == _currentFilter).toList();
    }
  }

  void _addAcademicYear(AcademicYear newAcademicYear) {
    setState(() {
      _academicYears.add(newAcademicYear);
      // Sắp xếp lại để dễ nhìn, ví dụ theo năm và học kỳ
      _academicYears.sort((a, b) {
        int yearCompare = a.year.compareTo(b.year);
        if (yearCompare != 0) return yearCompare;
        return a.term.index.compareTo(b.term.index);
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã khởi tạo ${newAcademicYear.cohort} - ${_getTermText(newAcademicYear.term)} - ${newAcademicYear.year} thành công!',
        ),
      ),
    );
  }

  void _initializeAcademicYear(String academicYearId, DateTime selectedDate) {
    setState(() {
      final index = _academicYears.indexWhere((ay) => ay.id == academicYearId);
      if (index != -1) {
        _academicYears[index] = _academicYears[index].copyWith(
          status: AcademicYearStatus.initialized,
          startDate: selectedDate, // ✅ lưu ngày bắt đầu
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã cập nhật trạng thái năm học thành "Đã khởi tạo".'),
      ),
    );
  }

  String _getTermText(AcademicTerm term) {
    switch (term) {
      case AcademicTerm.term1:
        return 'Học kỳ 1';
      case AcademicTerm.term2:
        return 'Học kỳ 2';
      case AcademicTerm.summerTerm:
        return 'Học kỳ hè';
    }
  }

  // void _showCreateAcademicYearSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
  //     ),
  //     builder: (context) {
  //       return CreateAcademicYearBottomSheet(onCreate: _addAcademicYear);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 248, 248),
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Khởi tạo năm học'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Các nút lọc theo trạng thái
          FilterStatusButtons(
            currentFilter: _currentFilter,
            onFilterChanged: (status) {
              setState(() {
                _currentFilter = status;
              });
            },
          ),
          const SizedBox(height: 8),
          // Danh sách các năm học
          Expanded(
            child: _filteredAcademicYears.isEmpty
                ? Center(
                    child: Text(
                      _currentFilter == AcademicYearStatus.initialized
                          ? 'Chưa có năm học nào được khởi tạo.'
                          : _currentFilter == AcademicYearStatus.notInitialized
                          ? 'Không có năm học nào chờ khởi tạo.'
                          : 'Chưa có năm học nào.',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredAcademicYears.length,
                    itemBuilder: (context, index) {
                      final academicYear = _filteredAcademicYears[index];
                      return AcademicYearListItem(
                        academicYear: academicYear, // ✅ đúng tên biến
                        onInitialize: (selectedDate) {
                          _initializeAcademicYear(
                            academicYear.id,
                            selectedDate,
                          ); // ✅ truyền đúng dữ liệu
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _showCreateAcademicYearSheet,
      //   tooltip: 'Khởi tạo năm học mới',
      //   child: const Icon(Icons.add, color: Colors.white),
      //   backgroundColor: Colors.blueAccent,
      // ),
    );
  }
}
