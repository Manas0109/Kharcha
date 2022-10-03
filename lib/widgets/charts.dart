// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_test/models/Transaction.dart';
import 'package:my_test/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  late final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get GroupedTransactionValues {
    return List.generate(7, (index) {
      final Weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == Weekday.day &&
            recentTransaction[i].date.month == Weekday.month &&
            recentTransaction[i].date.year == Weekday.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      print(DateFormat.E().format(Weekday));
      print(totalSum);

      return {"day": DateFormat.E().format(Weekday).substring(0,1), "amount": totalSum};
    });
  }

  double get totalSpending {
    return GroupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(GroupedTransactionValues);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: GroupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar
              (data["day"] as String, 
              data["amount"] as double, 
              totalSpending == 0.0 ? 0.0: (data["amount"] as double)/ totalSpending)
              );
          }).toList(),
        ),
      ),
    );
  }
}
