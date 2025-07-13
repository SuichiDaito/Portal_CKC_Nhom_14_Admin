class Room {
  final int id;
  final String ten;
  final int soLuong;
  final int loaiPhong;

  RoomStatus status;

  Room({
    required this.id,
    required this.ten,
    required this.soLuong,
    required this.loaiPhong,
    this.status = RoomStatus.available,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      ten: json['ten'],
      soLuong: int.parse(json['so_luong'].toString() ?? '') ?? 0,
      loaiPhong: json['loai_phong'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ten': ten,
    'so_luong': soLuong,
    'loai_phong': loaiPhong,
  };

  Room copyWith({
    String? ten,
    int? soLuong,
    int? loaiPhong,
    RoomStatus? status,
  }) {
    return Room(
      id: id,
      ten: ten ?? this.ten,
      soLuong: soLuong ?? this.soLuong,
      loaiPhong: loaiPhong ?? this.loaiPhong,
      status: status ?? this.status,
    );
  }

  static Room empty() => Room(id: 0, ten: '', soLuong: 0, loaiPhong: 0);
}

enum RoomType { lectureHall, laboratory, meetingRoom, other }

enum RoomStatus { available, inUse, maintenance }
