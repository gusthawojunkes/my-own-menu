import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';

loading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

themeApp() {
  return ThemeData(
      canvasColor: ColorsUtils.background,
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: ColorsUtils.darkBlue,
        displayColor: ColorsUtils.darkBlue,
      ),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: ColorsUtils.darkYellow),
      appBarTheme: AppBarTheme(
          color: ColorsUtils.darkYellow,
          iconTheme: IconThemeData(color: ColorsUtils.darkBlue)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsUtils.darkYellow,
        selectedIconTheme: IconThemeData(color: ColorsUtils.darkBlue),
        unselectedIconTheme: IconThemeData(color: ColorsUtils.lightBlue),
        selectedItemColor: ColorsUtils.darkBlue,
      ),
      dividerColor: ColorsUtils.darkYellow,
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: ColorsUtils.darkBlue),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.darkYellow)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.darkYellow))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.white),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => ColorsUtils.darkBlue))),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => ColorsUtils.lightYellow),
              foregroundColor: MaterialStateProperty.resolveWith(
                  (states) => ColorsUtils.darkBlue))));
}
