class ThongTinBacSi {
  String iId;
  String iDBS;
  String hoTen;
  String diaChi;
  String namSinh;
  String sDT;

  ThongTinBacSi(
    {required this.iId, 
    required this.iDBS,
    required this.hoTen, 
    required this.diaChi, 
    required this.namSinh, required this.sDT});

  ThongTinBacSi.fromJson(Map<String, dynamic> json, this.diaChi, this.hoTen, this.iDBS, this.iId, this.namSinh, this.sDT) {
    iId = json['_id'] ?? '';
    iDBS = json['ID_BS'];
    hoTen = json['HoTen'];
    diaChi = json['DiaChi'];
    namSinh = json['NamSinh'];
    sDT = json['SDT'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = iId;
    data['ID_BS'] = iDBS;
    data['HoTen'] = hoTen;
    data['DiaChi'] = diaChi;
    data['NamSinh'] = namSinh;
    data['SDT'] = sDT;
    return data;
  }
}

