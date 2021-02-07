import 'package:expensetracker/models/transation.dart';
import 'package:expensetracker/resourceAssets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransationList extends StatelessWidget {
  List<Transation> transactions;

  TransationList({this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .55,
        child: transactions.length <= 0
            ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("No Transaction found yet...!"),
                  SizedBox(height: 30,),
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset(zzzImage)),
                ],
              )
            : ListView.builder(
                // reverse: true,
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "₹${transactions[index].amount.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          margin: EdgeInsets.only(left: 5, right: 20),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transactions[index].title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              // transation.date.toString(),
                              DateFormat('dd-MM-yyyy')
                                  .format(transactions[index].date),
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ));
  }
}

// Container(
// height: MediaQuery.of(context).size.height*.55,
// child: SingleChildScrollView(
// scrollDirection: Axis.vertical,
// child: Column(
// children: transactions.map((transation) {
// return Card(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// child: Text(
// "₹${transation.amount}",
// style: TextStyle(
// color: Colors.deepPurpleAccent,
// fontSize: 15,
// fontWeight: FontWeight.bold),
// ),
// padding: EdgeInsets.all(5),
// decoration: BoxDecoration(
// border: Border.all(
// color: Colors.deepPurple,
// width: 3,
// ),
// borderRadius: BorderRadius.all(Radius.circular(5)),
// ),
// margin: EdgeInsets.only(left: 5, right: 20),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// transation.title,
// style: TextStyle(
// color: Colors.black,
// fontWeight: FontWeight.bold,
// fontSize: 15),
// ),
// Text(
// // transation.date.toString(),
// DateFormat('dd-MM-yyyy').format(transation.date),
// style: TextStyle(fontSize: 15),
// ),
// ],
// )
// ],
// ),
// );
// }).toList(),
// ),
// ),
// );
