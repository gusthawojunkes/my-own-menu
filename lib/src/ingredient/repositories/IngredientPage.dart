import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flip_card/flip_card.dart';
import 'package:myownmenu/models/Stock.dart';
import 'package:myownmenu/service/StockService.dart';
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
  final _searchController = TextEditingController();
  List<TextEditingController> _controllers = [];
  bool _visibilityFilters = false;
  bool visibleSaveButton = false;
  List<dynamic> listFilters = [];
  List listFiltersSelected = [];
  bool visibleListingredients = true;

  buildAsyncPage() {
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

    Widget cardIngredient(ingredient, index, image) {
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
                      ingredient.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text(
                      ingredient.type.name,
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

    Widget cardSelect(ingredient, index, controller) {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Card(
          child: Row(
            children: [
              Container(
                  height: 110,
                  color: ColorsUtils.darkBlue,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        Icons.check_box,
                        color: Colors.white,
                      ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: Text(
                              ingredient.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 15),
                            child: Text(
                              ingredient.type.name,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 40,
                        width: 130,
                        child: TextFormField(
                          controller: controller,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (value) {
                            // ingredient.quantity = controller.text;
                            visibleSaveButton = true;
                          },
                          decoration: InputDecoration(
                            helperText:
                                'Quantidade atual: 1',
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorsUtils.darkYellow),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          child: Icon(Icons.save),
                          onPressed: () {
                            try {
                              StockService.create(
                                  name: ingredient.name,
                                  type: ingredient.type);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Quantidade salva com sucesso!')),
                              );
                            } on FirebaseAuthException catch (error) {
                              print(error.code);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Algo deu errado!\n Tente novamente')),
                              );
                            }
                          })
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(builder: (
      BuildContext context,
      BoxConstraints viewportConstraints,
    ) {
      return FutureBuilder(
          future: StockService.getAll(),
          initialData: [],
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      new Container(
                        child: Column(
                          children: [
                            new Row(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 20.0, left: 30),
                                    child: Text(
                                      'Ingredientes',
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
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    labelText: 'O que deseja?',
                                    border: OutlineInputBorder(),
                                    suffixIcon: new IconButton(
                                      icon: new Icon(Icons.filter_list),
                                      onPressed: () async {
                                        setState(() {
                                          _visibilityFilters =
                                              !_visibilityFilters;
                                        });
                                        if (listFilters.length == 0)
                                          listFilters =
                                              await TypeService.getAll();
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
                          child: new Column(
                            children: [
                              new Container(
                                margin: const EdgeInsets.all(30),
                                child: new SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(listFilters.length,
                                        (index) {
                                      return FlipCard(
                                        speed: 1,
                                        front: Container(
                                          child: filter(
                                              listFilters,
                                              index,
                                              Colors.white,
                                              ColorsUtils.darkBlue),
                                        ),
                                        back: Container(
                                          child: filter(
                                              listFilters,
                                              index,
                                              ColorsUtils.darkBlue,
                                              Colors.white),
                                        ),
                                        onFlip: () async {
                                          setState(() {
                                            visibleListingredients = false;
                                            visibleListingredients = true;
                                            if (listFiltersSelected.contains(
                                                listFilters[index].name)) {
                                              listFiltersSelected.removeWhere(
                                                  (element) =>
                                                      element ==
                                                      listFilters[index].name);
                                            } else {
                                              listFiltersSelected
                                                  .add(listFilters[index].name);
                                            }
                                          });
                                        },
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      new Visibility(
                        visible: visibleListingredients,
                        child: new Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  _controllers.add(new TextEditingController());
                                  if (snapshot.data.isEmpty) {
                                    return CircularProgressIndicator();
                                  } else {
                                    Stock stock = snapshot.data[index];
                                    if (((!listFiltersSelected.contains(stock.type.name)) &&
                                            (listFiltersSelected.length > 0)) ||
                                        ((_searchController.text != "") &&
                                            (stock.name !=
                                                _searchController.text))) {
                                      return Text('');
                                    } else {
                                      _controllers
                                          .add(new TextEditingController());
                                      return FlipCard(
                                        front: Container(
                                          child: cardIngredient(
                                              stock,
                                              index,
                                              ''),
                                        ),
                                        back: Container(
                                          child: cardSelect(
                                              stock,
                                              index,
                                              _controllers[index]),
                                        ),
                                      );
                                    }
                                  }
                                })),
                      )
                    ],
                  ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(body: buildAsyncPage());
  }
}
