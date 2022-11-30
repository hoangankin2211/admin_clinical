class ThongTinBenhNhan {
  String iId;
  String iDBN;
  String hoTen;
  String gioiTinh;
  String diaChi;
  String ngaySinh;
  String sDT;

  ThongTinBenhNhan(
      {required this.iId,
      required this.iDBN,
      required this.hoTen,
      required this.gioiTinh,
      required this.diaChi,
      required this.ngaySinh,
      required this.sDT});

  ThongTinBenhNhan.fromJson(Map<String, dynamic> json, this.diaChi, this.gioiTinh, this.hoTen, this.iDBN, this.iId, this.ngaySinh, this.sDT) {
    iId = json['_id'] ?? '';
    iDBN = json['ID_BN'];
    hoTen = json['HoTen'];
    gioiTinh = json['GioiTinh'];
    diaChi = json['DiaChi'];
    ngaySinh = json['NgaySinh'];
    sDT = json['SDT'];
  }
  
  get data => null;

  Map<String, dynamic> toJson() {
    data['_id'] = iId;
    data['ID_BN'] = iDBN;
    data['HoTen'] = hoTen;
    data['GioiTinh'] = gioiTinh;
    data['DiaChi'] = diaChi;
    data['NgaySinh'] = ngaySinh;
    data['SDT'] = sDT;
    return data;
  }
}
