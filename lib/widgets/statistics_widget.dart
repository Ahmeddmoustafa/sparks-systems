import 'package:flutter/material.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key, required this.title, required this.value});
  final String title;
  final num value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        tileColor: Colors.grey[200],
        leading: const Icon(Icons.dataset),
        title: Text(title),
        trailing: Text(value.toString()),
      ),
    );
  }
}
