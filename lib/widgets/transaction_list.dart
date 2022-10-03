// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  
  final List<Transaction> transaction;
  final Function deletetx;
  TransactionList(this.transaction,this.deletetx );

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transaction.isEmpty 
      ? Column(
        children: <Widget>[
          Text("No Transactions added yet!!", style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 200,
            child: Image.asset("assets/Images/empty_img.jpg", fit: BoxFit.cover,)
            ),
        ],
      ): ListView.builder(

        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
            child: ListTile(
              
              leading: CircleAvatar(
                radius: 30,
              child: Padding(padding: EdgeInsets.all(6),child: FittedBox(child: Text("\₹${transaction[index].amount}"),),),
              ),
              
              title: Text(transaction[index].title, style: Theme.of(context).textTheme.headline6,),
              subtitle: Text(DateFormat.yMMMd().format(transaction[index].date)),

              trailing: IconButton(onPressed: (() => deletetx(transaction[index].id)), icon: Icon(Icons.delete), color: Colors.red,),
            ),
          );
        },
        itemCount: transaction.length,
      ),
    );
  }
}
