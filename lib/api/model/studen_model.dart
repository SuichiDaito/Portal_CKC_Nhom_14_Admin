enum StudentStatus { active, inactive, graduated, suspended }

class Student {
  final String id;
  final String studentCode;
  final String fullName;
  final String className;
  StudentStatus status;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;

  Student({
    required this.id,
    required this.studentCode,
    required this.fullName,
    required this.className,
    required this.status,
    this.email = '',
    this.phoneNumber = '',
    required this.dateOfBirth,
  });

  Student copyWith({
    String? id,
    String? studentCode,
    String? fullName,
    String? className,
    StudentStatus? status,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) {
    return Student(
      id: id ?? this.id,
      studentCode: studentCode ?? this.studentCode,
      fullName: fullName ?? this.fullName,
      className: className ?? this.className,
      status: status ?? this.status,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
