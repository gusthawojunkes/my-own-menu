import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flip_card/flip_card.dart';
import 'package:myownmenu/service/TypeService.dart';
import 'package:myownmenu/src/registerType/repositories/RegisterTypeModule.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';
import 'package:myownmenu/utils/SourceUtils.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class Dispense extends StatelessWidget {
  const Dispense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      theme: themeApp(),
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
  List listFilters = [];
  List<dynamic> listIngredients = __getIngredients();
  List<bool> listVisible = _getVisibility();
  bool visibilityFilter = false;
  final _searchController = TextEditingController();

  @override
  initState() {
    startAsyncInit();
  }

  Future startAsyncInit() async {
    setState(() async {
      listFilters = await TypeService.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget filter(
        listFilters, int index, dynamic backgroundColor, dynamic fontColor) {
      return Card(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.network(
                    SourceUtils.TYPE_URL_SRC +
                        listFilters[index].image +
                        ".png",
                    height: 64,
                  ),
                  Text(
                    listFilters[index].name,
                    style: TextStyle(
                        height: 4,
                        fontWeight: FontWeight.bold,
                        color: fontColor),
                  ),
                ],
              )));
    }

    Widget cardIngredient(index) {
      return Card(
        child: new Container(
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
      return new Card(
        child: new Container(
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
                  color: ColorsUtils.darkBlue,
                  child: InkWell(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          Icons.indeterminate_check_box,
                          color: Colors.white,
                        )),
                    onTap: () {
                      setState(() {
                        listVisible[index] = !listVisible[index];
                      });
                    },
                  )),
            ],
          ),
        ),
      );
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
                              padding: EdgeInsets.only(top: 10),
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
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: new Row(
                              children:
                                  List.generate(listFilters.length, (index) {
                                return new FlipCard(
                                  speed: 1,
                                  front: new Container(
                                    child: filter(listFilters, index,
                                        Colors.white, ColorsUtils.darkBlue),
                                  ),
                                  back: new Container(
                                    child: filter(listFilters, index,
                                        ColorsUtils.darkBlue, Colors.white),
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
