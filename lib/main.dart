import 'package:expensetracker/models/transation.dart';
import 'package:expensetracker/widgets/chart.dart';
import 'package:expensetracker/widgets/newTransaction.dart';
import 'package:expensetracker/widgets/transationList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // if(Platform.isIOS){
    //   print("ios");
    // }else{
    //   print("android");
    // }

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
  int serialNumber=0;

  final List<Transation> _transations = [
    Transation(id: "t1", title: "Car Rent", amount: 2, date: DateTime.now()),
    Transation(id: "t2", title: "Milk loan", amount: 300, date: DateTime.now()),
    Transation(id: "t3", title: "Bike loan", amount: 500, date: DateTime.now()),
    Transation(id: "t4", title: "shop Bill", amount: 300, date: DateTime.now().subtract(Duration(days: 1))),
    Transation(id: "t5", title: "car wash Bill", amount: 300, date: DateTime.now().subtract(Duration(days: 2))),
    Transation(id: "t6", title: "Bike loan", amount: 500, date: DateTime.now()),
    Transation(id: "t7", title: "grociries Bill", amount: 700, date: DateTime.now().subtract(Duration(days: 3))),
    Transation(id: "t8", title: "oil mill Bill", amount: 900, date: DateTime.now().subtract(Duration(days: 5))),
  ];

  List<Transation> get _recentTransation {
    return _transations.where((tx) {
     return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTrsansation(String title, double amount,DateTime txDate) {
    final newTransaction = Transation(
        id: DateTime.now().toString() + "${serialNumber++}",
        title: title,
        amount: amount,
        date: txDate);
    // print("calling set state");
    setState(() {
      _transations.add(newTransaction);
    });
  }

  void _deleteTransation(String id){
    setState(() {
      _transations.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(
              newTransactionFunction: _addNewTrsansation,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
       for(var tx in _transations){
         print("${tx.id} + ${tx.title}");
       }

    // print(DateTime.now().subtract(Duration(days: 2)));
    // final dateValue = DateTime.now().subtract(Duration(days: 1));
    // print(dateValue);
    // print(dateValue.weekday);

    // String df = DateFormat("E").format(dateValue);
    // print(df[0]);

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Last 7 Days statics",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w800),)),
            Chart(recentTransations: _recentTransation),
            TransationList(transactions: _transations.reversed.toList(),deleteTrnx: _deleteTransation,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
