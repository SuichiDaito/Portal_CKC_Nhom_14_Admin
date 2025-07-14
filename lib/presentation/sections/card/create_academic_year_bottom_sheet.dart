
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
// import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
// import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
// import 'package:portal_ckc/presentation/sections/dropdown_selector.dart';

// class CreateAcademicYearBottomSheet extends StatefulWidget {
//   final Function(NienKhoa) onCreate;

//   const CreateAcademicYearBottomSheet({Key? key, required this.onCreate})
//     : super(key: key);

//   @override
//   _CreateAcademicYearBottomSheetState createState() =>
//       _CreateAcademicYearBottomSheetState();
// }

// class _CreateAcademicYearBottomSheetState
//     extends State<CreateAcademicYearBottomSheet> {
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedCohort;
//   int? _selectedStartYear;
//   DateTime _selectedStartDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     _selectedCohort = _getCohortOptions().first.value;
//     _selectedStartYear = DateTime.now().year;
//   }

//   List<DropdownItem> _getCohortOptions() {
//     final currentYear = DateTime.now().year;
//     return List.generate(5, (index) {
//       final cohortYear = currentYear + 2 - index;
//       return DropdownItem(
//         value: '$cohortYear-${cohortYear + 3}', // VD: 2025-2028
//         label: 'Niên khóa $cohortYear-${cohortYear + 3}',
//         icon: Icons.school,
//       );
//     });
//   }

//   List<DropdownItem> _getYearOptions() {
//     final currentYear = DateTime.now().year;
//     return List.generate(5, (index) {
//       final year = currentYear + 2 - index;
//       return DropdownItem(
//         value: year.toString(),
//         label: year.toString(),
//         icon: Icons.calendar_today,
//       );
//     });
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedStartDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2050),
//     );
//     if (picked != null) {
//       setState(() {
//         _selectedStartDate = picked;
//       });
//     }
//   }

//   void _createAcademicYear() {
//     if (_formKey.currentState!.validate()) {
//       if (_selectedCohort == null || _selectedStartYear == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Vui lòng chọn đầy đủ thông tin.')),
//         );
//         return;
//       }

//       final parts = _selectedCohort!.split('-');
//       final namBatDau = parts[0];
//       final namKetThuc = parts[1];

//       final nienKhoa = NienKhoa(
//         id: 0, // ID tạm, backend sẽ gán khi lưu
//         tenNienKhoa: _selectedCohort!,
//         namBatDau: namBatDau,
//         namKetThuc: namKetThuc,
//         trangThai: 0,
//         hocKys: [], // Mặc định rỗng
//       );

//       widget.onCreate(nienKhoa);
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         top: 20,
//         left: 16,
//         right: 16,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//       ),
//       child: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Tạo mới niên khóa',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               DropdownSelector(
//                 label: 'Niên khóa',
//                 selectedItem: _getCohortOptions().firstWhere(
//                   (item) => item.value == _selectedCohort,
//                   orElse: () => _getCohortOptions().first,
//                 ),
//                 items: _getCohortOptions(),
//                 onChanged: (item) {
//                   setState(() {
//                     _selectedCohort = item?.value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 12),
//               DropdownSelector(
//                 label: 'Năm bắt đầu',
//                 selectedItem: _getYearOptions().firstWhere(
//                   (item) => item.value == _selectedStartYear.toString(),
//                   orElse: () => _getYearOptions().first,
//                 ),
//                 items: _getYearOptions(),
//                 onChanged: (item) {
//                   setState(() {
//                     _selectedStartYear = int.tryParse(item?.value ?? '');
//                   });
//                 },
//               ),
//               const SizedBox(height: 12),
//               GestureDetector(
//                 onTap: () => _selectDate(context),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: 'Ngày bắt đầu tuần đầu tiên',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(
//                         Icons.date_range,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                     controller: TextEditingController(
//                       text: DateFormat('dd/MM/yyyy').format(_selectedStartDate),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   CustomButton(
//                     text: 'Hủy',
//                     onPressed: () => Navigator.pop(context),
//                     backgroundColor: Colors.grey.shade300,
//                     textColor: Colors.black87,
//                   ),
//                   const SizedBox(width: 12),
//                   CustomButton(text: 'Tạo', onPressed: _createAcademicYear),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

