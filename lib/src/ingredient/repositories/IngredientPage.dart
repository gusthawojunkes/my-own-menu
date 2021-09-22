import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ingredient extends StatelessWidget {
  const Ingredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      debugShowCheckedModeBanner: false,
      home: IngredientPage(),
    );
  }
}

class IngredientPage extends StatefulWidget {
  const IngredientPage({Key? key}) : super(key: key);

  @override
  _IngredientPageState createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        new Container(
          child: Image.asset(
            './lib/assets/BackgroundTop.png',
            fit: BoxFit.fill,
          ),
        ),
      ]),
    );
  }
}
