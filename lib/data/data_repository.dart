import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sparks_app/models/order_model.dart';

abstract class DataRepository {
  Future<List<OrderModel>> loadJsonData();
}

class DataRepositoryImpl implements DataRepository {
  @override
  Future<List<OrderModel>> loadJsonData() async {
    // Load the JSON file
    String jsonString = await rootBundle.loadString('assets/orders-json.json');

    // Decode the JSON data
    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    List<dynamic> ordersJson = jsonData['data']['orders'];
    // print(jsonData);

    final List<OrderModel> orders = [];

    ordersJson.forEach((order) {
      orders.add(OrderModel.fromJson(order as Map<String, dynamic>));
    });

    // print(orders.length);

    return orders;
  }
}
