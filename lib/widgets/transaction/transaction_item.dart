import 'package:expansesapp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  
  final Transaction transaction;
  final Function deleteTxHandler;
  
  const TransactionItem(
    this.transaction,
    this.deleteTxHandler,
  );

  Widget _getTransactionPrice(BuildContext ctx, double amount) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Theme.of(ctx).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: FittedBox(
          child: Text(
            '${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: Theme.of(ctx).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDeleteButton(BuildContext ctx, double widthSize, String txId) {
    if (MediaQuery.of(ctx).size.width > widthSize) {
      return FlatButton.icon(
        icon: const Icon(Icons.delete),
        label: const Text('Deletar'),
        textColor: Theme.of(ctx).errorColor,
        onPressed: () => deleteTxHandler(txId),
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.delete),
        color: Theme.of(ctx).errorColor,
        onPressed: () => deleteTxHandler(txId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: _getTransactionPrice(
          context,
          transaction.amount,
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(transaction.date),
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
        trailing: _getDeleteButton(
          context,
          400,
          transaction.id,
        ),
      ),
    );
  }
}