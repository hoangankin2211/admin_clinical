class BaoCaoSuDungThuoc {
  String iId;
  String iDBCSDT;
  String thang;
  String iDThuoc;
  String soLuong;
  String soLanDung;

  BaoCaoSuDungThuoc(
      {required this.iId,
      required this.iDBCSDT,
      required this.thang,
      required this.iDThuoc,
      required this.soLuong,
      required this.soLanDung});

  BaoCaoSuDungThuoc.fromJson(Map<String, dynamic> json, this.iDBCSDT, this.iDThuoc, this.iId, this.soLanDung, this.soLuong, this.thang) {
    iId = json['_id'] ?? '';
    iDBCSDT = json['ID_BCSDT'];
    thang = json['Thang'];
    iDThuoc = json['ID_Thuoc'];
    soLuong = json['SoLuong'];
    soLanDung = json['SoLanDung'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = iId;
    data['ID_BCSDT'] = iDBCSDT;
    data['Thang'] = thang;
    data['ID_Thuoc'] = iDThuoc;
    data['SoLuong'] = soLuong;
    data['SoLanDung'] = soLanDung;
    return data;
  }
}
