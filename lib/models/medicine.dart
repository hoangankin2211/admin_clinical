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
