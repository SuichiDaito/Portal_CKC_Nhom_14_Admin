class ChuongTrinhDaoTao {
  final int id;
  final String tenChuongTrinhDaoTao;

  ChuongTrinhDaoTao({required this.id, required this.tenChuongTrinhDaoTao});

  factory ChuongTrinhDaoTao.fromJson(Map<String, dynamic> json) {
    return ChuongTrinhDaoTao(
      id: json['id'],
      tenChuongTrinhDaoTao: json['ten_chuong_trinh_dao_tao'],
    );
  }

  factory ChuongTrinhDaoTao.empty() =>
      ChuongTrinhDaoTao(id: 0, tenChuongTrinhDaoTao: '');
}
