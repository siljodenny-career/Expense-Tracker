
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

// ignore: constant_identifier_names
enum Category { Food , Travel , Leisure , Work , Shopping}

final formatter = DateFormat.yMd();

const categoryIcons ={
  Category.Food : Icons.lunch_dining,
  Category.Leisure : Icons.movie,
  Category.Travel: Icons.flight_takeoff,
  Category.Work:Icons.work,
  Category.Shopping: Icons.shopping_cart,
};

class Expense {
  Expense( {
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date); 
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
