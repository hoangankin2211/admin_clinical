class ThongTinKham {
  String? iId;
  String? iDTTK;
  String? soHoSo;
  String? iDTT;
  String? iDPK;
  String? iDBS;
  String? iDBN;
  String? ngayLap;
  String? nhipTim;
  String? huyetAp;
  String? nhietDo;
  String? chieuCao;
  String? nhipTho;
  String? canNang;
  String? tienKham;
  String? ghiChu;
  String? duDoanBenh;
  List<Thuoc>? thuoc;

  ThongTinKham(
      {iId,
      iDTTK,
      soHoSo,
      iDTT,
      iDPK,
      iDBS,
      iDBN,
      ngayLap,
      nhipTim,
      huyetAp,
      nhietDo,
      chieuCao,
      nhipTho,
      canNang,
      tienKham,
      ghiChu,
      duDoanBenh,
      thuoc});

  ThongTinKham.fromJson(Map<String?, dynamic> json) {
    iId = json['_id'] ?? '';
    iDTTK = json['ID_TTK'];
    soHoSo = json['SoHoSo'];
    iDTT = json['ID_TT'];
    iDPK = json['ID_PK'];
    iDBS = json['ID_BS'];
    iDBN = json['ID_BN'];
    ngayLap = json['NgayLap'];
    nhipTim = json['NhipTim'];
    huyetAp = json['HuyetAp'];
    nhietDo = json['NhietDo'];
    chieuCao = json['ChieuCao'];
    nhipTho = json['NhipTho'];
    canNang = json['CanNang'];
    tienKham = json['TienKham'];
    ghiChu = json['GhiChu'];
    duDoanBenh = json['DuDoanBenh'];
    if (json['Thuoc'] != null) {
      thuoc = <Thuoc>[];
      json['Thuoc'].forEach((v) {
        thuoc?.add(new Thuoc.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['_id'] = iId;
    data['ID_TTK'] = iDTTK;
    data['SoHoSo'] = soHoSo;
    data['ID_TT'] = iDTT;
    data['ID_PK'] = iDPK;
    data['ID_BS'] = iDBS;
    data['ID_BN'] = iDBN;
    data['NgayLap'] = ngayLap;
    data['NhipTim'] = nhipTim;
    data['HuyetAp'] = huyetAp;
    data['NhietDo'] = nhietDo;
    data['ChieuCao'] = chieuCao;
    data['NhipTho'] = nhipTho;
    data['CanNang'] = canNang;
    data['TienKham'] = tienKham;
    data['GhiChu'] = ghiChu;
    data['DuDoanBenh'] = duDoanBenh;
    if (thuoc != null) {
      data['Thuoc'] = thuoc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Thuoc {
  String? iDThuoc;
  String? soLuong;

  Thuoc({iDThuoc, soLuong});

  Thuoc.fromJson(Map<String?, dynamic> json) {
    iDThuoc = json['ID_Thuoc'];
    soLuong = json['SoLuong'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['ID_Thuoc'] = iDThuoc;
    data['SoLuong'] = soLuong;
    return data;
  }
}
