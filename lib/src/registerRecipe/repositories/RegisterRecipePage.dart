import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';

class RegisterRecipe extends StatelessWidget {
  const RegisterRecipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Receita',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: RegisterRecipePage(),
    );
  }
}

class RegisterRecipePage extends StatefulWidget {
  const RegisterRecipePage({Key? key}) : super(key: key);

  @override
  _RegisterRecipePageState createState() => _RegisterRecipePageState();
}

class _RegisterRecipePageState extends State<RegisterRecipePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _ingredientController = TextEditingController();
  TextEditingController _prepareModeController = TextEditingController();
  TextEditingController _additionalInformationsController =
      TextEditingController();
  late List<dynamic> listIngredients = [];
  List<dynamic> listIngredientsName = _getIngredientName(_getIngredients());
  late List<String> listPrepareMode = [];
  List<bool> listVisible = _getVisibility();
  bool _visibleIngredient = false;
  bool _visiblePrepareMode = false;
  bool _addIngredient = false;
  final _formKey = GlobalKey<FormState>();
  var myControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SingleChildScrollView(
          child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    new Row(
                      children: [
                        new Text(
                          'Cadastro de Receita',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 24.0),
                        )
                      ],
                    ),
                    new Column(
                      children: [
                        new Container(
                          padding: EdgeInsets.only(top: 30.0),
                          child: new TextFormField(
                            validator: (value) {
                              if (_nameController.text.isEmpty) {
                                return 'Campo Obrigatório!';
                              }
                            },
                            controller: _nameController,
                            decoration: new InputDecoration(
                              labelText: 'Nome',
                              border: new OutlineInputBorder(),
                              suffixIcon: new Icon(
                                Icons.room_service,
                              ),
                            ),
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: new Row(children: [
                            new Expanded(
                              flex: 6,
                              child: new TextFormField(
                                validator: (value) {
                                  if (listIngredients.isEmpty) {
                                    return 'Campo Obrigatório!';
                                  } else {
                                    _addIngredient = true;
                                  }
                                },
                                controller: _ingredientController,
                                decoration: new InputDecoration(
                                  labelText: 'Ingediente',
                                  border: new OutlineInputBorder(),
                                  suffixIcon: new Icon(
                                    Icons.extension,
                                  ),
                                ),
                              ),
                            ),
                            new SizedBox(
                              width: 10,
                            ),
                            new Expanded(
                                flex: 2,
                                child: new Visibility(
                                    visible: true,
                                    child: new SizedBox(
                                      height: 60,
                                      child: new ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (_ingredientController
                                                .text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'O valor inserido não pode ser vazio!')),
                                              );
                                            } else if (((_ingredientController
                                                        .text !=
                                                    "") &&
                                                ((!listIngredientsName.contains(
                                                    _ingredientController
                                                        .text))))) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'O ingrediente não existe!')),
                                              );
                                            } else {
                                              listIngredients.add(
                                                  _ingredientController.text);
                                              myControllers
                                                  .add(TextEditingController());
                                            }
                                          });
                                        },
                                        child: new Icon(
                                          Icons.add,
                                        ),
                                      ),
                                    ))),
                            new SizedBox(
                              width: 10,
                            ),
                            new Visibility(
                                visible: listIngredients.isNotEmpty,
                                child: new Expanded(
                                    flex: 2,
                                    child: new SizedBox(
                                      height: 60,
                                      child: new ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _visibleIngredient =
                                                !_visibleIngredient;
                                          });
                                        },
                                        child: new Icon(
                                          Icons.visibility,
                                        ),
                                      ),
                                    )))
                          ]),
                        ),
                        new Visibility(
                            visible: _visibleIngredient,
                            child: new Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: new Column(
                                  children: List.generate(
                                      listIngredients.length, (index) {
                                    return new Card(
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          new Column(
                                            children: [
                                              new Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    right: 15,
                                                    bottom: 5),
                                                child: new Text(
                                                  listIngredients[index],
                                                  style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          new Container(
                                            child: new TextFormField(
                                              controller: myControllers
                                                  .elementAt(index),
                                              decoration: new InputDecoration(
                                                labelText: 'Quantidade',
                                                border:
                                                    new OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          new SizedBox(
                                            height: 60,
                                            child: new ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  listIngredients
                                                      .removeAt(index);
                                                });
                                              },
                                              child: new Icon(
                                                Icons.indeterminate_check_box,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                ))),
                        new Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: new Row(children: [
                            new Expanded(
                              flex: 6,
                              child: new TextFormField(
                                validator: (value) {
                                  if (listPrepareMode.isEmpty) {
                                    return 'Campo Obrigatório!';
                                  }
                                },
                                controller: _prepareModeController,
                                decoration: new InputDecoration(
                                  labelText: 'Modo de Preparo',
                                  border: new OutlineInputBorder(),
                                  suffixIcon: new Icon(
                                    Icons.local_dining,
                                  ),
                                ),
                              ),
                            ),
                            new SizedBox(
                              width: 10,
                            ),
                            new Expanded(
                                flex: 2,
                                child: new SizedBox(
                                  height: 60,
                                  child: new ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_ingredientController
                                            .text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'O valor inserido não pode ser vazio!')),
                                          );
                                        } else {
                                          listPrepareMode
                                              .add(_prepareModeController.text);
                                        }
                                      });
                                    },
                                    child: new Icon(
                                      Icons.add,
                                    ),
                                  ),
                                )),
                            new SizedBox(
                              width: 10,
                            ),
                            new Visibility(
                                visible: listPrepareMode.isNotEmpty,
                                child: new Expanded(
                                    flex: 2,
                                    child: new SizedBox(
                                      height: 60,
                                      child: new ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _visiblePrepareMode =
                                                !_visiblePrepareMode;
                                          });
                                        },
                                        child: new Icon(
                                          Icons.visibility,
                                        ),
                                      ),
                                    )))
                          ]),
                        ),
                        new Visibility(
                            visible: _visiblePrepareMode,
                            child: new Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: new Column(
                                  children: List.generate(
                                      listPrepareMode.length,
                                      (index) => new Card(
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                new Column(
                                                  children: [
                                                    new Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10,
                                                          right: 15,
                                                          bottom: 5),
                                                      child: new Text(
                                                        listPrepareMode[index],
                                                        style: new TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                new SizedBox(
                                                  height: 60,
                                                  child: new ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        listPrepareMode
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    child: new Icon(
                                                      Icons
                                                          .indeterminate_check_box,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                ))),
                      ],
                    ),
                    new Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          new Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: const Text('Cadastrar'),
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Verifique o formulário!')),
                                      );
                                    } else {
                                      try {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterRecipe()),
                                        );
                                      } on FirebaseAuthException catch (error) {
                                        print(error.code);
                                      }
                                    }
                                  })),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      )),
    );
  }
}

String? validate(String value) {
  if (value.isEmpty) {
    return "Campo obrigatório";
  }
  return null;
}

List<dynamic> _getIngredients() {
  String ingredientsJson =
      '{"ingredients":[{"name":"Abacate","type":"Fruta"},{"name":"Alcatra","type":"Carne"},{"name":"Arroz","type":"Grão"},{"name":"Feijão","type":"Grão"},{"name":"Maça","type":"Fruta"},{"name":"Milho","type":"Grão"}]}';

  Map<String, dynamic> mapIngredients = jsonDecode(ingredientsJson);
  List<dynamic> listIngredients = mapIngredients['ingredients'];
  return listIngredients;
}

List<dynamic> _getIngredientName(listIngredients) {
  List<dynamic> listName = [];

  for (dynamic name in listIngredients) {
    listName.add(name['name']);
    // print(listName.indexOf(name['name']).toString() +
    //     'name: ' +
    //     name['name'].toString());
  }

  return listName;
}

List<bool> _getVisibility() {
  List<dynamic> listIngredients = _getIngredients();
  List<bool> listVisible = [];

  // ignore: unused_local_variable
  for (var ingredient in listIngredients) listVisible.add(true);
  return listVisible;
}
