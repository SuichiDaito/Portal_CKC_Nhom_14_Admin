class Room {
  final int id;
  final String ten;
  final int soLuong;
  final int loaiPhong;

  Room({
    required this.id,
    required this.ten,
    required this.soLuong,
    required this.loaiPhong,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      ten: json['ten'],
      soLuong: json['so_luong'],
      loaiPhong: json['loai_phong'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'ten': ten, 'so_luong': soLuong, 'loai_phong': loaiPhong};
  }
}
