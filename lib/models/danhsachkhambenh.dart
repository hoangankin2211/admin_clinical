class DanhSachKhamBenh {
  String iId;
  String ngayKham;
  String iDBN;

  DanhSachKhamBenh({required this.iId, required this.ngayKham, required this.iDBN});

  DanhSachKhamBenh.fromJson(Map<String, dynamic> json, this.iDBN, this.iId, this.ngayKham) {
    iId = json['_id'] ?? '';
    ngayKham = json['NgayKham'];
    iDBN = json['ID_BN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = iId;
    data['NgayKham'] = this.ngayKham;
    data['ID_BN'] = this.iDBN;
    return data;
  }
}
