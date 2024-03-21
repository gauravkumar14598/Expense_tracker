import 'package:flutter/material.dart';
import 'package:khata_type/model/expense.dart';
import 'package:khata_type/widgets/chart/chart.dart';
import 'package:khata_type/widgets/expense_list.dart';
import 'package:khata_type/widgets/new_expense.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Expense> expenseList = [
    Expense(
        title: 'Cinema',
        amount: 50,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Momos',
        amount: 30,
        date: DateTime.now(),
        category: Category.food),
  ];

  void gotoAdd() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewExpense(onAdd: addExpense);
        });
  }

  void addExpense(Expense expense) {
    List<Expense> temp = expenseList;
    temp.add(expense);
    setState(() {
      expenseList = temp;
    });
  }

  void _removeExpense(Expense expense) {
    var expenseIndex = expenseList.indexOf(expense);
    setState(() {
      expenseList.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted!'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                expenseList.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget startwidget = const Center(child: Text('No data is here:'));
    if (expenseList.isNotEmpty) {
      startwidget = ExpenseList(
        expenseList: expenseList,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Manager'),
        actions: [
          IconButton(
            onPressed: gotoAdd,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: expenseList,
          ),
          Expanded(child: startwidget),
        ],
      ),
    );
  }
}
