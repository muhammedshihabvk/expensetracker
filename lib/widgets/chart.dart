import 'package:expensetracker/models/transation.dart';
import 'package:expensetracker/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transation> recentTransations;

  Chart({this.recentTransations});
  var totalSum = 0.0;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday2 = DateTime.now().subtract(Duration(days: 6));
      final weekday = weekday2.add(Duration(days: index));

      // final weekday = DateTime.now().subtract(Duration(days: index));
      totalSum = 0.0;
      for (var i = 0; i < recentTransations.length; i++) {
        if (recentTransations[i].date.day == weekday.day &&
            recentTransations[i].date.month == weekday.month &&
            recentTransations[i].date.year == weekday.year) {
          totalSum += recentTransations[i].amount;
        }
      }
      // DateFormat.E().format(weekday);
      return {'day': DateFormat('E').format(weekday)[0], 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransactionValues.map((data) {
          // print("${data['day']}" +
          //     "${data['amount']}" +
          //     "${(data['amount'] as double) / totalSum}");
          return Flexible(
            fit: FlexFit.loose,
            child: ChartBar(
              label: data['day'],
              spendingAmount: data['amount'],
              spendingPctOfTotal:
                  totalSum == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
            ),
          );
        }).toList(),
      ),
    );
  }
}
