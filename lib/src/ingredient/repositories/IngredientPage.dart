import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/utils/SourceUtils.dart';
import 'Dart:convert';
import 'package:flip_card/flip_card.dart';

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
  List<dynamic> listIngredients = _getIngredients();
  HashSet<dynamic> listFilters = _getFilters();
  bool _visibilityFilters = true;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget cardIngredient(index) {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Container(
          color: Color.fromRGBO(219, 219, 219, 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 18, right: 15, bottom: 5),
                    child: Text(
                      listIngredients[index]['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text(
                      listIngredients[index]['type'],
                    ),
                  ),
                ],
              ),
              Image.asset(
                SourceUtils.INGREDIENTE_SRC,
              ),
            ],
          ),
        ),
      );
    }

    Widget cardSelect(index) {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Container(
          color: Color.fromRGBO(219, 219, 219, 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  color: Color.fromRGBO(156, 156, 156, 100),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        Icons.check_box,
                        color: Color.fromRGBO(0, 0, 0, 100),
                      ))),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: Text(
                      listIngredients[index]['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 15),
                    child: Text(
                      listIngredients[index]['type'],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget filter(int index, int r, int g, int b, double o) {
      return Card(
          color: Color.fromRGBO(r, g, b, o),
          clipBehavior: Clip.antiAlias,
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset(SourceUtils.LOGO_SRC),
                  Text(
                    listFilters.elementAt(index),
                    style: TextStyle(height: 4, fontWeight: FontWeight.bold),
                  ),
                ],
              )));
    }

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
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'O que deseja?',
                      border: OutlineInputBorder(),
                      suffixIcon: new IconButton(
                        icon: new Icon(Icons.filter_list),
                        onPressed: () {
                          setState(() {
                            _visibilityFilters = !_visibilityFilters;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        new Visibility(
          visible: _visibilityFilters,
          child: new Container(
            margin: const EdgeInsets.all(30),
            child: new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(listFilters.length, (index) {
                  return FlipCard(
                    speed: 1,
                    front: Container(
                      child: filter(index, 255, 255, 255, 100),
                    ),
                    back: Container(
                      child: filter(index, 173, 173, 173, 0),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: new Column(
            children: List.generate(listIngredients.length, (index) {
              return Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    FlipCard(
                      front: Container(
                        child: cardIngredient(index),
                      ),
                      back: Container(
                        child: cardSelect(index),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        )
      ],
    )));
  }
}

HashSet<String> _getFilters() {
  var listFilter = new HashSet<String>();
  List<dynamic> listIngredients = _getIngredients();

  for (var ingredient in listIngredients) listFilter.add(ingredient['type']);

  return listFilter;
}

List<dynamic> _getIngredients() {
  String ingredientsJson =
      '{"ingredients":[{"name":"Abacate","type":"Fruta"},{"name":"Alcatra","type":"Carne"},{"name":"Arroz","type":"Grão"},{"name":"Feijão","type":"Grão"},{"name":"Maça","type":"Fruta"},{"name":"Milho","type":"Grão"}]}';

  Map<String, dynamic> mapIngredients = jsonDecode(ingredientsJson);
  List<dynamic> listIngredients = mapIngredients['ingredients'];
  return listIngredients;
}
