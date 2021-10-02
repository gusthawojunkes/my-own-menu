import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/utils/SourceUtils.dart';
import 'package:animations/animations.dart';

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
  List<dynamic> ingredients = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                        'Ingredientes',
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
        new Container(
          margin: const EdgeInsets.all(30),
          child: new SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(ingredients.length, (index) {
                return new Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Image.asset(SourceUtils.LOGO_SRC),
                          Text(
                            "Teste",
                            style: TextStyle(
                                height: 4, fontWeight: FontWeight.bold),
                          ), //Dado de teste,
                        ],
                      ),
                    ));
              }),
            ),
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: new Column(
            children: List.generate(ingredients.length, (index) {
              return Padding(
                padding: EdgeInsets.all(0),
                child: new Card(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: InkWell(
                      splashColor: Colors.grey.withAlpha(50),
                      onTap: () {
                        print('Card tapped - ' + index.toString());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text(
                              "Ingrediente teste",
                              style: TextStyle(
                                height: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Image.asset(
                            SourceUtils.INGREDIENTE_SRC,
                          ),
                        ],
                      ),
                    )),
              );
            }),
          ),
        )
      ],
    )));
  }
}
