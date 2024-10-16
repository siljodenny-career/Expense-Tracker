import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Light Mode Color scheme.
//----------------------------------------
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 7, 2, 74),
);
//Dark Mode Color scheme.
//---------------------------------------
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
//---------------------------------------

void main() {
  //(Managing Device Orientation)
  WidgetsFlutterBinding
      .ensureInitialized(); //this line of code is required to make sure that locking the orientation and run the app as intended.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    //setuping of the device various Device Orientations as a list.we can add multiple orientations.
  ]).then((fn) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Expense Tracker',
        //Light Mode Theme
        //--------------------------------------------------------------------------------------------
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryFixed,
              foregroundColor: kColorScheme.primaryContainer),
          cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kColorScheme.onPrimaryContainer,
                  foregroundColor: kColorScheme.primaryContainer)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: kColorScheme.onSecondaryContainer,
                letterSpacing: 0.2,
              ),
              titleMedium: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: Color.fromARGB(233, 29, 54, 180),
              ),
              bodyMedium: TextStyle(
                  fontSize: 12,
                  color: kColorScheme.onPrimaryContainer)),
        ),
        //Dark Mode Theme
        //-------------------------------------------------------------------------------------------
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onSecondaryContainer),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: kColorScheme.onSecondaryContainer,
                  letterSpacing: 0.2,
                ),
                titleMedium: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: kDarkColorScheme.onPrimaryContainer),
                bodyMedium: TextStyle(
                  fontSize: 12,
                  color: kDarkColorScheme.onPrimaryContainer,
                ),
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer,
                  foregroundColor: kDarkColorScheme.onPrimaryContainer)),
          cardTheme: const CardTheme().copyWith(
              color: kDarkColorScheme.secondaryContainer,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        ),
        themeMode: ThemeMode.system,
        home: const Expenses(),
      ),
    );
  });
}
