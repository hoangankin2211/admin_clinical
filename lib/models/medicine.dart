import 'dart:convert';

class Medicine {
  final String id;
  final String name;
  final double price;
  final String provider;
  final String unit;
  final String type;

  Medicine({
    required this.type,
    required this.id,
    required this.name,
    required this.price,
    required this.provider,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      'type': type,
      'id': id,
      'name': name,
      'price': price,
      'provider': provider,
      'unit': unit,
    };

    return result;
  }
}

class Medicine1 {
  Medicine1 userFromJson(String str) => Medicine1.fromJson(json.decode(str));

  static String userToJson(Medicine1 data) => json.encode(data.toJson());

  String id;
  String name;
  String thumbnails;
  double price;
  double cost; // gia goc
  String type;
  String description;
  String unit;
  int amount;
  Medicine1({
    required this.id,
    required this.name,
    required this.thumbnails,
    required this.price,
    required this.cost,
    required this.type,
    required this.description,
    required this.unit,
    required this.amount,
  });
  factory Medicine1.fromMap(Map<String, dynamic> json) => Medicine1(
        id: json['_id'],
        name: json['name'],
        thumbnails: json['thumbnails'],
        price: json['price'],
        cost: json['cost'],
        type: json['type'],
        description: json['description'],
        unit: json['unit'],
        amount: json['amount'],
      );
  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'thumbnails': thumbnails,
        'price': price,
        'cost': cost,
        'type': type,
        'description': description,
        'unit': unit,
        'amount': amount,
      };

  factory Medicine1.fromJson(String source) =>
      Medicine1.fromMap(json.decode(source));

  Medicine1 copyWith({
    String? id,
    String? name,
    String? thumbnails,
    double? price,
    double? cost, // gia goc
    String? type,
    String? description,
    String? unit,
    int? amount,
  }) {
    return Medicine1(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnails: thumbnails ?? this.thumbnails,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      type: type ?? this.type,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
    );
  }
}
