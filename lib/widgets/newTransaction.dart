import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransactionFunction;

  NewTransaction({@required this.newTransactionFunction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitDate() {
    // print("called submitDate function");
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if(title.isEmpty || amount <= 0){
      return;
    }
    widget.newTransactionFunction(title, amount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
              onSubmitted: (_) => submitDate,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitDate,
            ),
            FlatButton(
              onPressed: submitDate,
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
