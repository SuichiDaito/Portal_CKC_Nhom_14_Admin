
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
// import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

// class NienKhoaListItem extends StatelessWidget {
//   final NienKhoa nienKhoa;
//   final Function(DateTime) onInitialize;

//   const NienKhoaListItem({
//     Key? key,
//     required this.nienKhoa,
//     required this.onInitialize,
//   }) : super(key: key);

//   String _getHocKyText() {
//     if (nienKhoa.hocKys.isEmpty) return 'Chưa có học kỳ';
//     final hocKyId = nienKhoa.hocKys[0].id;
//     switch (hocKyId) {
//       case 1:
//         return 'Học kỳ 1';
//       case 2:
//         return 'Học kỳ 2';
//       case 3:
//         return 'Học kỳ hè';
//       default:
//         return 'Không rõ học kỳ';
//     }
//   }

//   bool get _isInitialized => nienKhoa.namBatDau.isNotEmpty;

//   @override
//   Widget build(BuildContext context) {
//     final startDate = _isInitialized
//         ? DateFormat('yyyy-MM-dd').parse(nienKhoa.namBatDau)
//         : null;

//     return Card(
//       color: Colors.white,
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       elevation: 2.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Niên khóa: ${nienKhoa.tenNienKhoa}',
//               style: const TextStyle(fontSize: 15, color: Colors.black87),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Học kỳ: ${_getHocKyText()}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueAccent,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Ngày bắt đầu: ${startDate != null ? DateFormat('dd/MM/yyyy').format(startDate) : 'Chưa có'}',
//               style: const TextStyle(fontSize: 15, color: Colors.black87),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Text(
//                   'Trạng thái:',
//                   style: TextStyle(fontSize: 15, color: Colors.black87),
//                 ),
//                 const SizedBox(width: 8),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: _isInitialized
//                         ? Colors.green.withOpacity(0.1)
//                         : Colors.orange.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: _isInitialized ? Colors.green : Colors.orange,
//                     ),
//                   ),
//                   child: Text(
//                     _isInitialized ? 'Đã khởi tạo' : 'Chưa khởi tạo',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: _isInitialized ? Colors.green : Colors.orange,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (!_isInitialized)
//               Padding(
//                 padding: const EdgeInsets.only(top: 12.0),
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: CustomButton(
//                     text: 'Khởi tạo',
//                     onPressed: () async {
//                       final selectedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                         helpText: 'Chọn ngày bắt đầu học kỳ',
//                       );
//                       if (selectedDate != null) {
//                         onInitialize(selectedDate);
//                       }
//                     },
//                     backgroundColor: Colors.blue.shade600,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 8,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
