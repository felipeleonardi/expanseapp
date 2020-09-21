import 'dart:io';
import 'package:expansesapp/widgets/transaction/new_transaction.dart';
import 'package:expansesapp/widgets/transaction/user_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gastos Pessoais',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.white,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'Sapato Social',
      amount: 299.99,
      date: DateTime.now(),
    ),
    Transaction(
        id: 't2',
        title: 'Teclado Bluetooth',
        amount: 89.90,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
      id: 't3',
      title: 'Umidificador',
      amount: 270.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't4',
      title: 'Mouse Gamer',
      amount: 105.90,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't5',
      title: 'Echo Dot',
      amount: 349.90,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't6',
      title: 'Chrome Cast',
      amount: 259.90,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];
  bool _showChart = true;

  void _addNewTransaction(
    String title,
    double amount,
    DateTime choosenDate,
  ) {
    Transaction newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: choosenDate,
    );
    setState(() {
      transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _openNewTransactionForm(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) => NewTransaction(_addNewTransaction),
    );
  }

  PreferredSizeWidget _getAppBarContent(BuildContext ctx) {
    final String title = 'Gastos Pessoais';
    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        middle: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap: () => _openNewTransactionForm(ctx),
            ),
          ],
        ),
      );
    }
    return AppBar(
      title: Text(title),
      backgroundColor: Theme.of(ctx).primaryColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_circle),
          onPressed: () => _openNewTransactionForm(ctx),
        ),
      ],
    );
  }

  void _switchChart(bool valSwitch) {
    setState(() {
      _showChart = valSwitch;
    });
  }

  Widget _getFloatingActionButton() {
    if (!Platform.isIOS) {
      return FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _openNewTransactionForm(context),
      );
    }
    return Container();
  }

  Widget _getScaffold() {
    PreferredSizeWidget appBarContent = _getAppBarContent(context);
    Widget body = SafeArea(
      child: UserTransaction(
        transactions,
        _showChart,
        appBarContent.preferredSize.height,
        MediaQuery.of(context).padding.top,
        _deleteTransaction,
        _switchChart,
      ),
    );
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: appBarContent,
        child: body,
      );
    } else {
      return Scaffold(
        appBar: appBarContent,
        body: body,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _getFloatingActionButton(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getScaffold();
  }
}
