class TinhTrang {
  String iId;
  String iDTT;
  String tenTT;

  TinhTrang({required this.iId, required this.iDTT, required this.tenTT});

  TinhTrang.fromJson(Map<String, dynamic> json, this.iDTT, this.iId, this.tenTT) {
    iId = json['_id'] ?? '';
    iDTT = json['ID_TT'];
    tenTT = json['TenTT'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = iId;
    data['ID_TT'] = iDTT;
    data['TenTT'] = tenTT;
    return data;
  }
}