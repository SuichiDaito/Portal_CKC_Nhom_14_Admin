abstract class NganhKhoaEvent {}

/// Lấy tất cả danh sách khoa
class FetchAllKhoaEvent extends NganhKhoaEvent {}

/// Lấy tất cả danh sách ngành học
class FetchAllNganhHocEvent extends NganhKhoaEvent {}

/// Lấy cả danh sách khoa và ngành học trong một API
class FetchAllKhoaNganhEvent extends NganhKhoaEvent {}

/// Lọc danh sách ngành học theo ID khoa (nếu dùng riêng bộ lọc)
class FetchNganhTheoKhoaEvent extends NganhKhoaEvent {
  final int idKhoa;

  FetchNganhTheoKhoaEvent(this.idKhoa);
}

class FetchBoMonEvent extends NganhKhoaEvent {}

class FetchCTCTDTEvent extends NganhKhoaEvent {
  FetchCTCTDTEvent();
}
