import 'package:flutter/material.dart';
import 'package:khata_type/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAdd});
  final void Function(Expense) onAdd;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void trySubmit() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered ....'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    widget.onAdd(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: DateTime.now(),
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year, now.month, now.day + 10);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 50,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : _selectedDate.toString().substring(0, 10),
                  ),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: trySubmit,
                    child: const Text(
                      'Submit',
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
