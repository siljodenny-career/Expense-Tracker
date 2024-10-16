import 'dart:io';

import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selelctedCategory = Category.Travel;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  //Select Date icon button function
  void _presentDatePicker() async {
    final presentDate = DateTime.now();
    final firstDate =
        DateTime(presentDate.year - 1, presentDate.month, presentDate.day);
    final lastDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //SaveExpense Button functionality
  //-------------------------------------------------------------------------------------------------------

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); //tryParse('hello')=> null , tryParse('900')=> 900.
    final amountIsValid = enteredAmount == null ||
        enteredAmount <=
            0; //validating the entered amount by user is greater than zero and dont be a text value.

    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      //Show Alert Dialogues
      //-----------------------

      Platform.isIOS //verifying and showing of ios and android dialogues depending on which device the app is running.
          ? showCupertinoDialog(
              context: context,
              builder: (ctx) => CupertinoAlertDialog(
                title: const Text(
                  'Invalid Input',
                ),
                content: Text(_titleController.text.isEmpty &&
                        amountIsValid &&
                        _selectedDate == null
                    ? 'Please enter the Title , Amount and Date of the expense'
                    : _titleController.text.isEmpty
                        ? 'Please Enter the Title'
                        : amountIsValid
                            ? 'please enter amount'
                            : _selectedDate == null
                                ? 'Please enter date'
                                : ''),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Understood'))
                ],
              ),
            )
          : showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text(
                      'Invalid Input',
                      style: TextStyle(color: Color.fromARGB(238, 2, 102, 184)),
                    ),
                    content: Text(_titleController.text.isEmpty &&
                            amountIsValid &&
                            _selectedDate == null
                        ? 'Please enter the Title , Amount and Date of the expense'
                        : _titleController.text.isEmpty
                            ? 'Please Enter the Title'
                            : amountIsValid
                                ? 'please enter amount'
                                : _selectedDate == null
                                    ? 'Please enter date'
                                    : ''),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text('Understood'))
                    ],
                  ));
      return;
    }
    //this 'widget.' property helps to access data(functions,variables,etc) to parent class to State class. Here we can access 'onAddExpense' from NewExpense class(parent class) into _NewExpenseState class(state class).
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selelctedCategory));

    Navigator.pop(context);
  }
  //-----------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 16, 30, keyboardSpace + 16),
          child: Column(
            children: [
              const Text(
                'Add New Expense',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(228, 36, 119, 152),
                ),
              ),

              const SizedBox(height: 25),
              TextField(
                style:const TextStyle(color: Colors.blueGrey),
                controller: _titleController,
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    label: Text('Title'),
                    border: OutlineInputBorder(borderSide: BorderSide())),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style:const TextStyle(color: Colors.blueGrey),
                      decoration: const InputDecoration(
                          label: Text('Amount'),
                          prefix: Text('INR '),
                          border: OutlineInputBorder(borderSide: BorderSide())),
                    ),
                  ),

                  //Date Picker

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : formatter.format(_selectedDate!),
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              //Save expense and Cancel buttons

              Row(
                children: [
                  //Creating a Dropdown button with dropdownmenu items.

                  DropdownButton(
                      elevation: 10,
                      value: _selelctedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selelctedCategory = value;
                        });
                      }),
                  const Spacer(),

                  //Save Expense Button

                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'),
                  ),
                  const SizedBox(width: 10),

                  //Cancel Button

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
