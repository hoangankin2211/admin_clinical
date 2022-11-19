class Invoice {
  final String patientId;
  final String id;
  final String createDate;
  final double realPay;
  final double amount;
  final double discount;
  final List<String>? services;
  final List<String>? medicine;

  Invoice({
    required this.createDate,
    required this.patientId,
    required this.id,
    required this.amount,
    required this.discount,
    required this.services,
    required this.medicine,
    required this.realPay,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      'patientId': patientId,
      'id': id,
      'amount': amount,
      'createDate': createDate,
      'discount': discount,
      'services': services ?? 0,
      'medicine': medicine ?? 0,
    };
    return result;
  }
}
