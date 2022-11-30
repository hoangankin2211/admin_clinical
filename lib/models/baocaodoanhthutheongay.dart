class BaoCaoDoanhThuTheoNgay {
   String iId;
  String iDBCDT;
  String thang;
  String ngay;
  String soBenhNhan;
  String doanhThu;
  String tiLe;

  BaoCaoDoanhThuTheoNgay(
      {required this.iId,
      required this.iDBCDT,
      required this.thang,
      required this.ngay,
      required this.soBenhNhan,
      required this.doanhThu,
      required this.tiLe});

  BaoCaoDoanhThuTheoNgay.fromJson(Map<String, dynamic> json, this.iId, this.iDBCDT, this.thang, this.ngay, this.soBenhNhan, this.doanhThu, this.tiLe) {
    iId = json['_id'] ?? '';
    iDBCDT = json['ID_BCDT'];
    thang = json['Thang'];
    ngay = json['Ngay'];
    soBenhNhan = json['SoBenhNhan'];
    doanhThu = json['DoanhThu'];
    tiLe = json['TiLe'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = iId;
    data['ID_BCDT'] = iDBCDT;
    data['Thang'] = thang;
    data['Ngay'] = ngay;
    data['SoBenhNhan'] = soBenhNhan;
    data['DoanhThu'] = doanhThu;
    data['TiLe'] = tiLe;
    return data;
  }
}
