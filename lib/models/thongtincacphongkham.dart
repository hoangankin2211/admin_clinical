class ThongTinCacPhongKham {
  String iId;
  String iDPK;
  String ten;
  String tiepDon;
  String daKham;

  ThongTinCacPhongKham({required this.iId, required this.iDPK, required this.ten, required this.tiepDon, required this.daKham});

  ThongTinCacPhongKham.fromJson(Map<String, dynamic> json, this.daKham, this.iDPK, this.iId, this.ten, this.tiepDon) {
    iId = json['_id'] ?? '';
    iDPK = json['ID_PK'];
    ten = json['Ten'];
    tiepDon = json['TiepDon'];
    daKham = json['DaKham'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = iId;
    data['ID_PK'] = iDPK;
    data['Ten'] = ten;
    data['TiepDon'] = tiepDon;
    data['DaKham'] = daKham;
    return data;
  }
}
