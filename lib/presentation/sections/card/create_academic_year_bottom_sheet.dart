import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_tuan.dart';
import 'package:portal_ckc/presentation/pages/page_academic_year_management.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/dropdown_selector.dart';

enum AcademicTerm { term1, term2, summerTerm }

class CreateAcademicYearBottomSheet extends StatefulWidget {
  final Function(AcademicYear) onCreate;

  const CreateAcademicYearBottomSheet({Key? key, required this.onCreate})
    : super(key: key);

  @override
  _CreateAcademicYearBottomSheetState createState() =>
      _CreateAcademicYearBottomSheetState();
}

class _CreateAcademicYearBottomSheetState
    extends State<CreateAcademicYearBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCohort; // Niên khóa
  AcademicTerm? _selectedTerm; // Học kỳ
  int? _selectedYear; // Năm
  DateTime _selectedStartDate = DateTime.now(); // Ngày bắt đầu

  @override
  void initState() {
    super.initState();
    // Giá trị mặc định hoặc gợi ý
    _selectedCohort = _getCohortOptions().first.value;
    _selectedTerm = AcademicTerm.term1;
    _selectedYear = DateTime.now().year;
  }

  List<DropdownItem> _getCohortOptions() {
    final currentYear = DateTime.now().year;
    return List.generate(5, (index) {
      final cohortYear = currentYear + 2 - index; // Ví dụ: K27, K26, K25...
      return DropdownItem(
        value: 'K$cohortYear',
        label: 'K$cohortYear',
        icon: Icons.date_range,
      );
    });
  }

  List<DropdownItem> _getTermOptions() {
    return AcademicTerm.values.map((term) {
      String label;
      switch (term) {
        case AcademicTerm.term1:
          label = 'Học kỳ 1';
          break;
        case AcademicTerm.term2:
          label = 'Học kỳ 2';
          break;
        case AcademicTerm.summerTerm:
          label = 'Học kỳ hè';
          break;
      }
      return DropdownItem(
        value: term.toString(),
        label: label,
        icon: Icons.timelapse,
      );
    }).toList();
  }

  List<DropdownItem> _getYearOptions() {
    final currentYear = DateTime.now().year;
    return List.generate(5, (index) {
      final year = currentYear + 2 - index; // Ví dụ: 2027, 2026, 2025...
      return DropdownItem(
        value: year.toString(),
        label: year.toString(),
        icon: Icons.date_range,
      );
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueAccent, // Màu xanh chủ đạo
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
  }

  void _createAcademicYear() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCohort == null ||
          _selectedTerm == null ||
          _selectedYear == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng chọn đầy đủ thông tin.')),
        );
        return;
      }

      final newAcademicYear = AcademicYear(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        cohort: _selectedCohort!,
        term: _selectedTerm!,
        year: _selectedYear!,
        startDate: _selectedStartDate,
        status: AcademicYearStatus
            .notInitialized, // Mặc định là chưa khởi tạo khi mới tạo
      );

      widget.onCreate(newAcademicYear);
      Navigator.pop(context); // Đóng bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Khởi tạo năm học / học kỳ',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 20),
              DropdownSelector(
                label: 'Niên khóa',
                selectedItem: _getCohortOptions().firstWhere(
                  (item) => item.value == _selectedCohort,
                  orElse: () =>
                      _getCohortOptions().first, // Fallback nếu không tìm thấy
                ),
                items: _getCohortOptions(),
                onChanged: (item) {
                  setState(() {
                    _selectedCohort = item?.value;
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownSelector(
                label: 'Học kỳ',
                selectedItem: _getTermOptions().firstWhere(
                  (item) => item.value == _selectedTerm.toString(),
                  orElse: () => _getTermOptions().first,
                ),
                items: _getTermOptions(),
                onChanged: (item) {
                  setState(() {
                    _selectedTerm = AcademicTerm.values.firstWhere(
                      (e) => e.toString() == item?.value,
                    );
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownSelector(
                label: 'Năm',
                selectedItem: _getYearOptions().firstWhere(
                  (item) => item.value == _selectedYear.toString(),
                  orElse: () => _getYearOptions().first,
                ),
                items: _getYearOptions(),
                onChanged: (item) {
                  setState(() {
                    _selectedYear = int.tryParse(item?.value ?? '');
                  });
                },
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Ngày bắt đầu',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.blueAccent,
                      ),
                      suffixIcon: _selectedStartDate != null
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  // Có thể cho phép xóa ngày nếu muốn, hoặc không cần nút này
                                  // _selectedStartDate = null;
                                });
                              },
                            )
                          : null,
                    ),
                    controller: TextEditingController(
                      text: _selectedStartDate != null
                          ? DateFormat('dd/MM/yyyy').format(_selectedStartDate)
                          : '',
                    ),
                    validator: (value) {
                      if (_selectedStartDate == null) {
                        return 'Vui lòng chọn ngày bắt đầu.';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'Quay lại',
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: Colors.grey.shade300,
                    textColor: Colors.black87,
                  ),
                  const SizedBox(width: 12),
                  CustomButton(
                    text: 'Khởi tạo',
                    onPressed: _createAcademicYear,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
