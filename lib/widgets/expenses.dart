import 'dart:async';

import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  //Text banner transition on the HomeScreen
  //------------------------------------------------------------------------------------------------------------------
  List<String> texts = [
    '"The best thing about a budget is you stay in control of your finances."',
    '“Used correctly, a budget doesn’t restrict you. It empowers you.”',
    '“Budgeting isn’t about limiting yourself. It’s about making the things that excite you possible.”',
    '“When you set a budget, you are taking control of your future.”',
  ];
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % texts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  //--------------------------------------------------------------------------------------------------------------------

  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 599,
      date: DateTime.now(),
      category: Category.Work,
    ),
    Expense(
      title: 'Beef Steak',
      amount: 650,
      date: DateTime.now(),
      category: Category.Food,
    ),
    Expense(
      title: 'Cinema',
      amount: 120,
      date: DateTime.now(),
      category: Category.Leisure,
    ),
    Expense(
      title: 'Banglore',
      amount: 2890,
      date: DateTime.now(),
      category: Category.Travel,
    ),
    Expense(
      title: 'Grocery',
      amount: 1200,
      date: DateTime.utc(2023),
      category: Category.Shopping,
    )
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
      isScrollControlled: true,
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(
        expense); //this process makes each expense have unique index. this helps to retreive the particular expense from the Snackbar when we removed accidentally.
    setState(() {
      _registeredExpenses.remove(expense);
    });
    //Showing a snackbar of 'Expense Deleted' when we delete an expense and helps to retrieve the removed expense by Undo button on Snackbar.
    //----------------------------------------------------------------------------------------------------------------------------
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: const Text('Expense deleted'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
    //-----------------------------------------------------------------------------------------------------------------------------
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //here by printing mediaquery we can see the width and height of the running-app-device.By taking the measurement we can manage configuration of the screen widgets.

    Widget mainContent = Center(
      child: width < 600
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no_expense_wallpaper.png',
                  width: 400,
                  color: const Color.fromARGB(20, 255, 255, 255),
                ),
                const SizedBox(height: 20),
                const Text(
                  'No Expenses found.Add some expenses.',
                  style: TextStyle(
                      backgroundColor: Color.fromARGB(93, 24, 27, 29),
                      color: Color.fromARGB(62, 255, 255, 255),
                      fontSize: 15),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no_expense_wallpaper.png',
                  width: 300,
                  color: const Color.fromARGB(20, 255, 255, 255),
                ),
                const SizedBox(height: 20),
                const Text(
                  'No Expenses found.Add some expenses.',
                  style: TextStyle(
                      backgroundColor: Color.fromARGB(93, 24, 27, 29),
                      color: Color.fromARGB(62, 255, 255, 255),
                      fontSize: 13),
                ),
              ],
            ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = width < 600
          ? Column(
              children: [
                Expanded(
                    child: Image.asset(
                  'assets/images/no_expense_wallpaper.png',
                  alignment: Alignment.topCenter,
                )),
                //Text Banner Transition managing using AnimationSwitcher and transition type FadeTransition
                //-----------------------------------------------------------------------------------------------
                SizedBox(
                  width: 300,
                  height: 100,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) =>
                        FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    child: Text(
                      texts[_currentIndex],
                      key: ValueKey<String>(texts[_currentIndex]),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          wordSpacing: 1,
                          height: 1.3),
                    ),
                  ),
                ),
                //----------------------------------------------------------------------------------------------
                Chart(expenses: _registeredExpenses),
                Expanded(
                  flex: 2,
                  child: ExpensesList(
                    expenses: _registeredExpenses,
                    onRemoveExpense: _removeExpense,
                  ),
                ),
              ],
            )
          : Row(
            
            children: [
              Image.asset(
                'assets/images/no_expense_wallpaper.png',
                width: width/4,
                alignment: Alignment.topCenter,
              ),
              //Text Banner Transition managing using AnimationSwitcher and transition type FadeTransition
              //-----------------------------------------------------------------------------------------------
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 100,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (
                          Widget child,
                          Animation<double> animation,
                        ) =>
                            FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                        child: Text(
                          texts[_currentIndex],
                          key: ValueKey<String>(texts[_currentIndex]),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              wordSpacing: 1,
                              height: 1.3),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: Chart(
                                  expenses: _registeredExpenses)),
                          Expanded(
                            child: ExpensesList(
                              expenses: _registeredExpenses,
                              onRemoveExpense: _removeExpense,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //----------------------------------------------------------------------------------------------
              //const SizedBox(height: 10),
            ],
          );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
          const SizedBox(width: 15)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
