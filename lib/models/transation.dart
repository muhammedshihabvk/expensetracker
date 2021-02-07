import 'package:flutter/cupertino.dart';

class Transation {
  String id;
  String title;
  double amount;
  DateTime date;

  Transation({ @required this.id, @required this.title, @required this.amount, @required this.date});
}
