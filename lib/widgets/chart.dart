import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List get groupedTxnValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].datetime.day == weekDay.day &&
            recentTransactions[i].datetime.month == weekDay.month &&
            recentTransactions[i].datetime.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      print("day: ${DateFormat.E().format(weekDay)}");
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalAmount
      };
    }).reversed.toList();
  }

  double get totalSum {
    return groupedTxnValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTxnValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSum == 0.0 ? 0.0 : (data['amount'] as double) / totalSum,
                ),
              );
            }).toList(),
          ),
        ),
        elevation: 6,
      ),
    );
  }
}
