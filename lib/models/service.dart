import 'dart:convert';

class Service {
  String? id;
  String? name;
  String? departmentId;
  double? price;
  String? description;

  Service(
      {this.name,
      this.departmentId,
      this.price,
      this.description,
      required this.id});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    departmentId = json['departmentId'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['name'] = name;
    data['departmentId'] = departmentId;
    data['price'] = price;
    data['description'] = description;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
