import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

class Recipe extends StatelessWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      debugShowCheckedModeBanner: false,
      home: RecipePage(),
    );
  }
}

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Column(children: [
        new Container(
          child: Image.asset(
            SourceUtils.BACKGROUND_TOP_SRC,
            fit: BoxFit.fill,
          ),
        ),
      ]),
     );
  }
}
