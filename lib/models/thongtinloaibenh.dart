class ThhongTinLoaiBenh {
  String iId;
  String iDLB;
  String tenLB;

  ThhongTinLoaiBenh({required this.iId, required this.iDLB, required this.tenLB});

  ThhongTinLoaiBenh.fromJson(Map<String, dynamic> json, this.iDLB, this.iId, this.tenLB) {
    iId = json['_id'] ?? '';
    iDLB = json['ID_LB'];
    tenLB = json['TenLB'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = iId;
    data['ID_LB'] = iDLB;
    data['TenLB'] = tenLB;
    return data;
  }
}