import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class Recipe extends StatelessWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      theme: themeApp(),
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
  //Dados de teste para a visualiazação em tela das widgets.
  List<dynamic> recipes = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        new Container(
          child: Column(
            children: [
              new Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 30),
                      child: Text(
                        'Receitas',
                        style: TextStyle(color: Colors.black, fontSize: 24.0),
                      ))
                ],
              ),
              new Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 30, left: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'O que deseja?',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.filter_list,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        new Expanded(
            child: GridView.count(
          crossAxisSpacing: 30,
          mainAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(recipes.length, (index) {
            return new Card(
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Receita teste",
                      style: TextStyle(height: 4, fontWeight: FontWeight.bold),
                    ), //Dado de teste
                    Container(
                        child: Column(
                      children: List.generate(4, (index) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Ingrediente de teste',
                                style: TextStyle(height: 1.4),
                              ), //Dado de teste
                            ));
                      }),
                    )),
                  ],
                ),
              ),
            );
          }),
        ))
      ],
    )));
  }
}
