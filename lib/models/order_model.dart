// import 'dart:convert';

class OrderModel {
  final String id;
  final bool isActive;
  final double price;
  final String company;
  final String buyer;
  final String status;
  final DateTime registered;

  OrderModel({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.buyer,
    required this.status,
    required this.registered,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      isActive: json['isActive'],
      price: double.parse((json['price'] as String)
          .replaceAll(RegExp(r'[\$,]'), '')), // Parsing price to int
      company: json['company'],
      buyer: json['buyer'],
      status: json['status'],
      registered: DateTime.parse(json['registered']),
    );
  }

  // Method to convert an OrderModel object into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isActive': isActive,
      'price': price,
      'company': company,
      'buyer': buyer,
      'status': status,
      'registered': registered.toIso8601String(),
    };
  }
}
