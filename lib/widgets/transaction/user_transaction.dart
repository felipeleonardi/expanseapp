import 'package:expansesapp/models/transaction.dart';
import 'package:expansesapp/widgets/chart/chart.dart';
import 'package:expansesapp/widgets/transaction/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatelessWidget {
  final List<Transaction> transactions;
  final bool showChart;
  final double appBarHeight;
  final double paddingTopHeight;
  final Function deleteTxHandler;
  final Function switchHandler;

  UserTransaction(
    this.transactions,
    this.showChart,
    this.appBarHeight,
    this.paddingTopHeight,
    this.deleteTxHandler,
    this.switchHandler,
  );

  Widget _getEmptyTransationsMessage(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.2,
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Nenhum gasto foi adicionado ainda!',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.8,
              padding: const EdgeInsets.only(top: 40),
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    );
  }

  List<Transaction> _getRecentTransactions(List<Transaction> transactions) {
    return transactions
        .where(
          (tx) => tx.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  double _getResponsiveHeight(
    double pctOfVview,
    BuildContext ctx,
  ) {
    return (MediaQuery.of(ctx).size.height - appBarHeight - paddingTopHeight) *
        pctOfVview;
  }

  Widget _getTransactionsList(
      BuildContext ctx, List<Transaction> transactionsList) {
    Widget transactionView;
    if (transactionsList.isEmpty) {
      transactionView = _getEmptyTransationsMessage(ctx);
    } else {
      transactionView = TransactionList(transactionsList, deleteTxHandler);
    }
    return Container(
      height: _getResponsiveHeight(0.7, ctx),
      child: transactionView,
    );
  }

  Widget _getChartTransactions(
    final List<Transaction> recentTransactions,
    BuildContext ctx,
    bool isLandscape,
  ) {
    double height = isLandscape ? 0.74 : 0.3;
    return Container(
        height: _getResponsiveHeight(height, ctx),
        child: Chart(recentTransactions));
  }

  Widget _getSwitchChartButton(BuildContext ctx) {
    return Container(
      height: _getResponsiveHeight(0.26, ctx),
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Text(
            'Mostrar gráfico?',
            style: Theme.of(ctx).textTheme.title,
          ),
          Switch.adaptive(
            value: showChart,
            activeColor: Theme.of(ctx).primaryColor,
            onChanged: (val) => switchHandler(val),
          )
        ],
      ),
    );
  }

  List<Widget> _getApplicationBody(
    List<Transaction> transactions,
    BuildContext ctx,
    bool isLandscape,
  ) {
    List<Transaction> recentTransactions = _getRecentTransactions(transactions);
    Widget transactionList = _getTransactionsList(ctx, transactions);
    Widget chartTransactions =
        _getChartTransactions(recentTransactions, ctx, isLandscape);
    Widget switchChartButton = _getSwitchChartButton(ctx);
    if (recentTransactions.isEmpty) {
      return [transactionList];
    } else if (isLandscape) {
      if (showChart) {
        return [switchChartButton, chartTransactions, transactionList];
      } else {
        return [switchChartButton, transactionList];
      }
    } else {
      return [chartTransactions, transactionList];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final List<Widget> applicationBody =
        _getApplicationBody(transactions, context, isLandscape);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[...applicationBody],
      ),
    );
  }
}
