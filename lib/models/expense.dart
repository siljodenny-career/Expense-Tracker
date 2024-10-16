
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

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

