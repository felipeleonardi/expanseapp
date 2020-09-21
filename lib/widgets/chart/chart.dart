import 'package:expansesapp/models/grouped_transactions.dart';
import 'package:expansesapp/models/transaction.dart';
import 'package:expansesapp/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  bool _isEqualDates(DateTime firstDate, DateTime secondDate) {
    if (firstDate.day == secondDate.day &&
        firstDate.month == secondDate.month &&
        firstDate.year == secondDate.year) {
      return true;
    }
    return false;
  }

  List<GroupedTransactions> _getGroupedTransactionValues(
      List<Transaction> transactions) {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (Transaction tx in transactions) {
        if (_isEqualDates(tx.date, weekDay)) {
          totalSum += tx.amount;
        }
      }
      return GroupedTransactions(
        day: DateFormat.E('pt_BR').format(weekDay).substring(0, 3),
        amount: totalSum,
      );
    }).reversed.toList();
  }

  double _getTotalSpending(List<GroupedTransactions> groupedTransactions) {
    return groupedTransactions.fold(
        0.0, (previousValue, tx) => previousValue + tx.amount);
  }

  double _getSpendingPctOfTotal(
      double amount, List<GroupedTransactions> groupedTransactions) {
    return amount / _getTotalSpending(groupedTransactions);
  }

  _getChartBars(List<GroupedTransactions> groupedTransactions) {
    return groupedTransactions.map((tx) {
      return Flexible(
        fit: FlexFit.tight,
        child: ChartBar(
          tx.day,
          tx.amount,
          _getSpendingPctOfTotal(tx.amount, groupedTransactions),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<GroupedTransactions> groupedTransactionValues =
        _getGroupedTransactionValues(recentTransactions);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _getChartBars(groupedTransactionValues),
        ),
      ),
    );
  }
}
