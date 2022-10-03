// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_final_fields, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:my_test/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/Transaction.dart';
import './widgets/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: "Quicksand",
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)
                  ),
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle
              (color: Colors.white),
        ),
        )
        );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String titleInput;
  final List<Transaction> _userTransaction = [
  ];

  List<Transaction> get _recentTransactions{
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosendate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosendate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                Chart(_recentTransactions),
                TransactionList(_userTransaction,_deleteTransaction)
            ]
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddnewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
