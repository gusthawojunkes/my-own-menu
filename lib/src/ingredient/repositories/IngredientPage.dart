import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flip_card/flip_card.dart';
import 'package:myownmenu/service/IngredientService.dart';
import 'package:myownmenu/service/TypeService.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';
import 'package:myownmenu/utils/SourceUtils.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class Ingredient extends StatelessWidget {
  const Ingredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      theme: themeApp(),
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
  List listIngredients = [];
  List listIngredientsView = [];
  List listFilters = [];
  bool _visibilityFilters = true;
  TextEditingController _searchController = TextEditingController();

  @override
  // ignore: must_call_super
  initState() {
    startAsyncInit();
  }

  Future startAsyncInit() async {
    listFilters = await TypeService.getAll();
    listIngredientsView = await IngredientService.getAll();
  }

  @override
  Widget build(BuildContext buildContext) {
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

    Widget cardIngredient(List listIngredients, index) {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 18, right: 15, bottom: 5),
                    child: Text(
                      listIngredients[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text(
                      '',
                    ),
                  ),
                ],
              ),
              Image.asset(
                SourceUtils.INGREDIENTE_SRC,
                height: 60,
              ),
            ],
          ),
        ),
      );
    }

    Widget cardSelect(listIngredients, index) {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  color: ColorsUtils.darkBlue,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        Icons.check_box,
                        color: Colors.white,
                      ))),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: Text(
                      listIngredients[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 15),
                    child: Text(
                      '',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
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
                      child: filter(listFilters, index, Colors.white,
                          ColorsUtils.darkBlue),
                    ),
                    back: Container(
                      child: filter(listFilters, index, ColorsUtils.darkBlue,
                          Colors.white),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: FutureBuilder(
            future: IngredientService.getAll(),
            initialData: CircularProgressIndicator(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Column(
                  children: List.generate(listIngredientsView.length, (index) {
                    return FlipCard(
                      front: Container(
                        child: cardIngredient(listIngredientsView, index),
                      ),
                      back: Container(
                        child: cardSelect(listIngredientsView, index),
                      ),
                    );
                  }),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
      ],
    )));
  }
}
