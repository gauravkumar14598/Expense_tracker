import 'package:flutter/material.dart';
import 'package:khata_type/model/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({required this.expenseList, required this.removeExpense,super.key});
  final List<Expense> expenseList;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: ((context, index) {
        return Dismissible(
          key: ValueKey(expenseList[index]),
          background: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 132, 125),
            ),
          ),
          onDismissed: (direction){
            removeExpense(expenseList[index]);
          },
          child: Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expenseList[index].title),
                  Row(
                    children: [
                      Text('\$${expenseList[index].amount.toString()}'),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            categoryType[expenseList[index].category],
                          ),
                          Text(
                            expenseList[index].date.toString().substring(0, 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
