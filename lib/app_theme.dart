import 'package:flutter/material.dart';

class AppTheme {
  static  Color primaryColor = Color(0xFF5D9CEC);
  static  Color backgroundlight = Color(0xFFDFECDB);
  static  Color backgrounddark = Color(0xFF060E1E);
  static  Color white = Color(0XFFFFFFFF);
  static  Color grey = Color(0xFFC8C9CB);
  static  Color green = Color(0xFF16D455);
  static  Color red = Color(0xFFE70822);


  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle:
            TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: white)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: primaryColor,
    ),
    scaffoldBackgroundColor: backgroundlight,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: primaryColor),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
        color: backgrounddark,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: backgrounddark
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: backgrounddark
      )
    ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
      )
    )
        )
      )
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(backgroundColor: white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: white, selectedItemColor: primaryColor),
    scaffoldBackgroundColor: white,

    
  );
}
