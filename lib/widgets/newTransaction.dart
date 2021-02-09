import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransactionFunction;


  NewTransaction({@required this.newTransactionFunction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitDate() {
    // print("called submitDate function");
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate ==null) {
      return;
    }
    widget.newTransactionFunction(title, amount,_selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2025),).then((datePicked) {
          if(datePicked == null){
              return;
          }else{
            setState(() {
              _selectedDate = datePicked;
              print(_selectedDate);
            });

          }
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Card(
      color: Colors.teal,
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              onSubmitted: (_) => _submitDate,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              onSubmitted: (_) => _submitDate,
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      "Choose date",
                      textScaleFactor: 1.2,
                    ),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(_selectedDate == null ? 'No Date Selected!' : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            FlatButton(
              onPressed: _submitDate,
              child: Text(
                "Add Transaction",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
