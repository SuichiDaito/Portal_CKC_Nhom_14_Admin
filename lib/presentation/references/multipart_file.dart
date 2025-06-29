// import 'dart:io';

// import 'package:http/http.dart' show MultipartFile;
// import 'package:path/path.dart';

// Future<List<MultipartFile>> convertToMultipartFiles(List<File> files) async {
//   return Future.wait(
//     files.map((file) async {
//       return MultipartFile.fromBytes(
//         'files', // tên field API yêu cầu
//         await file.readAsBytes(),
//         filename: basename(file.path),
//       );
//     }),
//   );
// }
