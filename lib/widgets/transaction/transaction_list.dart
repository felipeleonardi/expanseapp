import 'package:expansesapp/models/transaction.dart';
import 'package:expansesapp/widgets/transaction/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;
  final Function deleteTxHandler;

  TransactionList(
    this.transactionsList,
    this.deleteTxHandler,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return TransactionItem(
          transactionsList[index],
          deleteTxHandler,
        );
      },
      itemCount: transactionsList.length,
    );
  }
}
