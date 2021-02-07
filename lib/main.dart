
import 'package:expensetracker/models/transation.dart';
import 'package:expensetracker/widgets/newTransaction.dart';
import 'package:expensetracker/widgets/transationList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.teal,
        // fontFamily:

      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title;
  String amount;

  final List<Transation> _transations = [
    // Transation(id: "t1", title: "Car Rent", amount: 100, date: DateTime.now()),
    // Transation(id: "t2", title: "Home loan", amount: 200, date: DateTime.now()),
  ];

  void _addNewTrsansation(String title,double amount){
    final newTransaction = Transation(id: DateTime.now().toString()+"tx", title: title, amount: amount, date: DateTime.now());
    // print("calling set state");
    setState(() {
      _transations.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(newTransactionFunction: _addNewTrsansation,));
    },);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense"),
        actions: [
          IconButton(icon: Icon(Icons.add,size: 25,color: Colors.white,), onPressed: () => _startAddNewTransaction(context),)
        ],

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              color: Colors.blueAccent,
              child: Container(
                width: double.infinity,
                // height: MediaQuery.of(context).size.height*.35,
                child: Text("Chart"),
              ),
            ),
            // UserTransaction(),
            TransationList(transactions: _transations,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: () => _startAddNewTransaction(context),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );

  }
}
