// enum StudentStatus { active, inactive, graduated, suspended }

// class Student {
//   final String id; // ID duy nhất của sinh viên (có thể là MSSV)
//   final String studentCode; // Mã số sinh viên
//   final String fullName;
//   final String className; // Tên lớp (ví dụ: SE1812)
//   StudentStatus status;
//   // Các thông tin chi tiết khác có thể thêm vào sau này (ví dụ: email, số điện thoại...)
//   final String email;
//   final String phoneNumber;
//   final DateTime dateOfBirth;

//   Student({
//     required this.id,
//     required this.studentCode,
//     required this.fullName,
//     required this.className,
//     required this.status,
//     this.email = '',
//     this.phoneNumber = '',
//     required this.dateOfBirth,
//   });

//   // Helper to create a copy for potential future editing or passing data
//   Student copyWith({
//     String? id,
//     String? studentCode,
//     String? fullName,
//     String? className,
//     StudentStatus? status,
//     String? email,
//     String? phoneNumber,
//     DateTime? dateOfBirth,
//   }) {
//     return Student(
//       id: id ?? this.id,
//       studentCode: studentCode ?? this.studentCode,
//       fullName: fullName ?? this.fullName,
//       className: className ?? this.className,
//       status: status ?? this.status,
//       email: email ?? this.email,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//     );
//   }
// }
