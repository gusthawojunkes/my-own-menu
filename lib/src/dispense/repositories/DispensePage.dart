import 'dart:collection';
import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

class Dispense extends StatelessWidget {
  const Dispense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      debugShowCheckedModeBanner: false,
      home: DispensePage(),
    );
  }
}

class DispensePage extends StatefulWidget {
  const DispensePage({Key? key}) : super(key: key);

  @override
  _DispensePageState createState() => _DispensePageState();
}

class _DispensePageState extends State<DispensePage> {
  HashSet<dynamic> listFilters = _getFilters();
  List<dynamic> listIngredients = __getIngredients();
  List<bool> listVisible = _getVisibility();
  bool visibilityFilter = false;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget cardIngredient(index) {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: new Container(
          color: Color.fromRGBO(219, 219, 219, 100),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Column(
                children: [
                  new Padding(
                    padding: EdgeInsets.only(top: 18, right: 15, bottom: 5),
                    child: new Text(
                      listIngredients[index]['name'],
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(right: 5),
                    child: new Text(
                      listIngredients[index]['type'],
                    ),
                  ),
                ],
              ),
              new Image.asset(
                SourceUtils.INGREDIENTE_SRC,
              ),
            ],
          ),
        ),
      );
    }

    Widget cardSelect(index, listIngredients) {
      return new Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: new Container(
          color: Color.fromRGBO(219, 219, 219, 100),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Column(
                children: [
                  new Padding(
                    padding: EdgeInsets.only(top: 10, right: 15, bottom: 5),
                    child: new Text(
                      listIngredients[index]['name'],
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 15),
                    child: new Text(
                      listIngredients[index]['type'],
                    ),
                  ),
                ],
              ),
              new Container(
                  color: Color.fromRGBO(156, 156, 156, 100),
                  child: new Padding(
                      padding: EdgeInsets.all(15),
                      child: new TextButton(
                          child: const Icon(
                            Icons.indeterminate_check_box,
                            color: Color.fromRGBO(0, 0, 0, 100),
                          ),
                          onPressed: () {
                            setState(() {
                              listVisible[index] = !listVisible[index];
                            });
                          }))),
            ],
          ),
        ),
      );
    }

    Widget filter(int index, int r, int g, int b, double o) {
      return new Card(
          color: Color.fromRGBO(r, g, b, o),
          clipBehavior: Clip.antiAlias,
          child: new Padding(
              padding: const EdgeInsets.all(16),
              child: new Column(
                children: [
                  Image.asset(SourceUtils.LOGO_SRC),
                  new Text(
                    listFilters.elementAt(index),
                    style:
                        new TextStyle(height: 4, fontWeight: FontWeight.bold),
                  ),
                ],
              )));
    }

    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: new Padding(
                  padding: EdgeInsets.only(right: 30, left: 30, bottom: 30),
                  child: new Column(
                    children: [
                      new Container(
                        child: Column(
                          children: [
                            new Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'Dispensa',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 24.0),
                                    ))
                              ],
                            ),
                            new Container(
                              padding: EdgeInsets.only(top: 10, bottom: 20),
                              child: new TextFormField(
                                controller: _searchController,
                                decoration: new InputDecoration(
                                  prefixIcon: new Icon(Icons.search),
                                  labelText: 'O que deseja?',
                                  border: new OutlineInputBorder(),
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.filter_list),
                                    onPressed: () {
                                      setState(() {
                                        visibilityFilter = !visibilityFilter;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Visibility(
                        visible: visibilityFilter,
                        child: new Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: new Row(
                              children:
                                  List.generate(listFilters.length, (index) {
                                return new FlipCard(
                                  speed: 1,
                                  front: new Container(
                                    child: filter(index, 255, 255, 255, 100),
                                  ),
                                  back: new Container(
                                    child: filter(index, 173, 173, 173, 0),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      new Column(
                        children:
                            List.generate(listIngredients.length, (index) {
                          return new Padding(
                            padding: EdgeInsets.all(0),
                            child: new Column(
                              children: [
                                new FlipCard(
                                  front: new Visibility(
                                    visible: listVisible[index],
                                    child: cardIngredient(index),
                                  ),
                                  back: new Visibility(
                                    visible: listVisible[index],
                                    child: cardSelect(index, listIngredients),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )
                    ],
                  ))));
    }));
  }
}

HashSet<String> _getFilters() {
  var listFilter = new HashSet<String>();
  List<dynamic> listIngredients = __getIngredients();

  for (var ingredient in listIngredients) listFilter.add(ingredient['type']);

  return listFilter;
}

List<dynamic> __getIngredients() {
  String ingredientsJson =
      '{"ingredients":[{"name":"Alface","type":"Verdura"},{"name":"Abacate","type":"Fruta"},{"name":"Alcatra","type":"Carne"},{"name":"Arroz","type":"Grão"},{"name":"Feijão","type":"Grão"},{"name":"Maça","type":"Fruta"},{"name":"Milho","type":"Grão"}]}';

  Map<String, dynamic> mapIngredients = jsonDecode(ingredientsJson);
  List<dynamic> listIngredients = mapIngredients['ingredients'];
  return listIngredients;
}

List<bool> _getVisibility() {
  List<dynamic> listIngredients = __getIngredients();
  List<bool> listVisible = [];

  // ignore: unused_local_variable
  for (var ingredient in listIngredients) listVisible.add(true);
  return listVisible;
}
