class HoaDonThanhToan {
  String iId;
  String iDBN;
  String iDTTK;

  HoaDonThanhToan({required this.iId, required this.iDBN, required this.iDTTK});

  HoaDonThanhToan.fromJson(Map<String, dynamic> json, this.iDBN, this.iDTTK, this.iId) {
    iId = json['_id'] ?? '';
    iDBN = json['ID_BN'];
    iDTTK = json['ID_TTK'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = iId;
    data['ID_BN'] = iDBN;
    data['ID_TTK'] = iDTTK;
    return data;
  }
}

