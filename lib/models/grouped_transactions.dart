import 'package:flutter/foundation.dart';

class GroupedTransactions {
  final String day;
  final double amount;

  GroupedTransactions({
    @required this.day,
    @required this.amount
  });
}