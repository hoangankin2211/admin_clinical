class ThongTinThuoc {
  String iId;
  String iDThuoc;
  String ten;
  String giaGoc;
  String giaBan;
  String donVi;
  String cachDung;

  ThongTinThuoc(
      {required this.iId,
      required this.iDThuoc,
      required this.ten,
      required this.giaGoc,
      required this.giaBan,
      required this.donVi,
      required this.cachDung});

  ThongTinThuoc.fromJson(Map<String, dynamic> json, this.cachDung, this.donVi, this.giaBan, this.giaGoc, this.iDThuoc, this.iId, this.ten) {
    iId = json['_id'] ?? '';
    iDThuoc = json['ID_Thuoc'];
    ten = json['Ten'];
    giaGoc = json['GiaGoc'];
    giaBan = json['GiaBan'];
    donVi = json['DonVi'];
    cachDung = json['CachDung'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = iId;
    data['ID_Thuoc'] = iDThuoc;
    data['Ten'] = ten;
    data['GiaGoc'] = giaGoc;
    data['GiaBan'] = giaBan;
    data['DonVi'] = donVi;
    data['CachDung'] = cachDung;
    return data;
  }
}

