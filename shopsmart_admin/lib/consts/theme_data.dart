import 'package:flutter/material.dart';

import 'app_colors.dart';

class Styles {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
        scaffoldBackgroundColor: isDarkTheme
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
        cardColor: isDarkTheme
            ? AppColors.darkCardColor
            : AppColors.lightCardColor,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          backgroundColor: isDarkTheme
              ? AppColors.darkScaffoldColor
              : AppColors.lightScaffoldColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          bodyMedium: TextStyle(
            color: isDarkTheme ? Colors.white70 : Colors.black54,
          ),
        ),
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        dividerColor: isDarkTheme ? Colors.white10 : Colors.black12,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding: const EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.error,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.error,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ));
  }
}
