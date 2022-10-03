// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime datechoose = DateTime.now();
  
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount =double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount<=0){
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, datechoose);
    Navigator.of(context).pop();
  }

  void selectDate(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2022),
      lastDate: DateTime.now()).then((pickedDate) {

        setState(() {
          datechoose = pickedDate!;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: ((value) => submitData()),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              onSubmitted: (value) => submitData(),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Text(DateFormat.yMd().format(datechoose)),
                FlatButton(
                  onPressed: selectDate, 
                  child: Text(
                    "Choose Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold),
                      )
                ),
              ],
            ),
            RaisedButton(
              onPressed: submitData,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button?.color,
              child: Text("Add Transaction"),
            )
          ],
        ),
      ),
    );
  }
}
