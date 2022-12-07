import 'dart:convert';

class Invoice {
  Invoice userFromJson(String str) => Invoice.fromJson(json.decode(str));

  static String userToJson(Invoice data) => json.encode(data.toJson());

  String id;
  DateTime createTime;
  int status;
  String category;
  double amount;
  String thumb;
  String title;
  String medicineId;
  String hrId;
  Invoice({
    required this.id,
    required this.createTime,
    required this.status,
    required this.category,
    required this.medicineId,
    required this.amount,
    required this.title,
    required this.thumb,
    required this.hrId,
  });
  factory Invoice.fromMap(Map<String, dynamic> json) => Invoice(
      id: json['_id'],
      createTime: DateTime.fromMillisecondsSinceEpoch(json["createTime"]),
      status: json['status'],
      category: json['category'],
      medicineId: json['medicineId'],
      amount: json['amount'],
      title: json['title'],
      thumb: json['thumb'],
      hrId: json['hrId']);
  Map<String, dynamic> toJson() => {
        '_id': id,
        'createTime': createTime,
        'status': status,
        'category': category,
        'amount': amount,
        'title': title,
        'thumb': thumb,
        'medicineId': medicineId,
        'hrId': hrId
      };

  factory Invoice.fromJson(String source) =>
      Invoice.fromMap(json.decode(source));

  Invoice copyWith({
    String? id,
    DateTime? createTime,
    int? status,
    String? category,
    String? medicineId,
    double? amount,
    String? title,
    String? thumb,
    String? hrId,
  }) {
    return Invoice(
        id: id ?? this.id,
        createTime: createTime ?? this.createTime,
        status: status ?? this.status,
        category: category ?? this.category,
        medicineId: medicineId ?? this.medicineId,
        amount: amount ?? this.amount,
        title: title ?? this.title,
        thumb: thumb ?? this.thumb,
        hrId: hrId ?? this.hrId);
  }
}
