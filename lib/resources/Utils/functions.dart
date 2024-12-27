// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:sparks_app/models/order_model.dart';

// Future<List<OrderModel>> loadJson() async {
//   // Load the JSON file
//   String jsonString = await rootBundle.loadString('assets/orders-json.json');

//   // Decode the JSON data
//   Map<String, dynamic> jsonData = jsonDecode(jsonString);

//   List<dynamic> ordersJson = jsonData['data']['orders'];
//   print(jsonData);

//   final List<OrderModel> orders = [];

//   ordersJson.forEach((order) {
//     orders.add(OrderModel.fromJson(order as Map<String, dynamic>));
//   });

//   // print(orders.length);

//   return orders;

//   // Use the data
// }
