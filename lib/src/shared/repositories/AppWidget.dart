import 'package:flutter/material.dart';
import 'package:myownmenu/src/welcome/repositories/WelcomePage.dart';

class MyOnwMenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Own Menu',
      home: Welcome(),
    );
  }
}
