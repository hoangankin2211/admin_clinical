import 'dart:convert';

class Medicine {
  Medicine userFromJson(String str) => Medicine.fromJson(json.decode(str));

  static String userToJson(Medicine data) => json.encode(data.toJson());

  String id;
  String name;
  String thumbnails;
  double price;
  double cost; // gia goc
  String type;
  String description;
  String unit;
  int amount;
  List<Map<String, dynamic>> listPass;
  Medicine({
    required this.id,
    required this.name,
    required this.thumbnails,
    required this.price,
    required this.cost,
    required this.type,
    required this.description,
    required this.unit,
    required this.amount,
    required this.listPass,
  });
  factory Medicine.fromMap(Map<String, dynamic> json) => Medicine(
        id: json['_id'],
        name: json['name'],
        thumbnails: json['thumbnails'],
        price: json['price'],
        cost: json['cost'],
        type: json['type'],
        description: json['description'],
        unit: json['unit'],
        amount: json['amount'],
        listPass: [
          for (var item in List<Map<String, dynamic>>.from((json['listPass'])))
            {
              'date': DateTime.fromMillisecondsSinceEpoch(item['date']),
              'price': item['price'],
              'remain': item['remain'],
            }
        ],
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
        'listPass': listPass,
      };

  factory Medicine.fromJson(String source) =>
      Medicine.fromMap(json.decode(source));

  Medicine copyWith({
    String? id,
    String? name,
    String? thumbnails,
    double? price,
    double? cost, // gia goc
    String? type,
    String? description,
    String? unit,
    int? amount,
    List<Map<String, dynamic>>? listPass,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnails: thumbnails ?? this.thumbnails,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      type: type ?? this.type,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
      listPass: listPass ?? this.listPass,
    );
  }
}
