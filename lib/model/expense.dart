import 'package:flutter/material.dart';

enum Category { food, leisure, travel, work }

const categoryType = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_land,
  Category.work: Icons.work,
};

class Expense {
  const Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category});
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => (element.category == category) ? true : false)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
