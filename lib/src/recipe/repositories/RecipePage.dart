import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/service/RecipeService.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';
import 'package:myownmenu/models/Recipe.dart' as Model;
import 'package:myownmenu/models/Step.dart' as Model;

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
  List<dynamic> recipes = [];
  bool _visibleRecipe = false;
  bool _visibleIngredient = false;

  buildAsyncPage() {
    return Container(
        child: FutureBuilder(
            future: RecipeService.getAll(),
            initialData: [],
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                recipes = snapshot.data;
                return Column(
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  ))
                            ],
                          ),
                          new Container(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0, right: 30, left: 30),
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
                      crossAxisSpacing: 10,
                      padding: EdgeInsets.only(
                          top: 10, left: 30, bottom: 30, right: 30),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 8.0 / 8.0,
                      children: List.generate(recipes.length, (index) {
                        Model.Recipe recipe = recipes[index];
                        String title = recipe.title;
                        int time = recipe.preparationTime;
                        List<Model.Step> steps = recipe.steps;
                        List<RecipeIngredient> ingredients = recipe.ingredients;
                        return new InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                      title: Text(title),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            new Container(
                                              child: Row(
                                                children: [
                                                  new Text(
                                                    "Tempo de preparo: ",
                                                    style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Icon(Icons.timer),
                                                  new Text(
                                                    " " +
                                                        time.toString() +
                                                        " min ",
                                                    style: TextStyle(height: 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            new Divider(
                                              height: 50,
                                            ),
                                            new Row(
                                              children: [
                                                Text(
                                                  "Ingredientes",
                                                  style: new TextStyle(
                                                    color:
                                                        ColorsUtils.darkYellow,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            new Visibility(
                                                visible: _visibleIngredient,
                                                child: new Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: new Column(
                                                      children: List.generate(
                                                          ingredients.length,
                                                          (index) =>
                                                              new Container(
                                                                child: new Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    new Column(
                                                                      children: [
                                                                        new Padding(
                                                                            padding: EdgeInsets.only(
                                                                                top: 10,
                                                                                right: 15,
                                                                                bottom: 5),
                                                                            child: Row(
                                                                              children: [
                                                                                new Card(
                                                                                    color: ColorsUtils.darkBlue,
                                                                                    child: new Padding(
                                                                                        padding: EdgeInsets.all(10),
                                                                                        child: new Container(
                                                                                          child: new Text(
                                                                                            ingredients[index].quantity.toString(),
                                                                                            style: new TextStyle(
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                        ))),
                                                                                new Text(
                                                                                  ingredients[index].ingredient.name,
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                    ))),
                                            new Divider(
                                              height: 50,
                                            ),
                                            new Row(
                                              children: [
                                                Text(
                                                  "Modo de Preparo",
                                                  style: new TextStyle(
                                                    color:
                                                        ColorsUtils.darkYellow,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            new Visibility(
                                                visible: _visibleRecipe,
                                                child: new Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: new Column(
                                                      children: List.generate(
                                                          steps.length,
                                                          (index) =>
                                                              new Container(
                                                                child: new Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    new Column(
                                                                      children: [
                                                                        new Padding(
                                                                            padding: EdgeInsets.only(
                                                                                top: 10,
                                                                                right: 15,
                                                                                bottom: 5),
                                                                            child: Row(
                                                                              children: [
                                                                                new Text(
                                                                                  steps[index].sequence.toString() + ". " + steps[index].description.toString(),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _visibleIngredient =
                                                      !_visibleIngredient;
                                                });
                                              },
                                              child: Text('Ingredientes'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _visibleRecipe =
                                                      !_visibleRecipe;
                                                });
                                              },
                                              child: Text('Preparo'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'Ok'),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                                },
                              );
                            },
                            child: new Container(
                                child: new Card(
                                    child: new Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        title,
                                        style: TextStyle(
                                            height: 4,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(Icons.timer),
                                          new Text(
                                            "  " +
                                                time.toString() +
                                                " min ",
                                            style: TextStyle(height: 1),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ))));
                      }),
                    ))
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildAsyncPage());
  }
}
