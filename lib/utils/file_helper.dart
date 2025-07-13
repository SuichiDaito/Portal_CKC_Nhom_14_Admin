import 'package:http/http.dart' show MultipartFile;
import 'package:file_picker/file_picker.dart';

List<MultipartFile> buildMultipartFiles(List<PlatformFile> files) {
  return files.map((f) {
    return MultipartFile('files[]', f.readStream!, f.size, filename: f.name);
  }).toList();
}
