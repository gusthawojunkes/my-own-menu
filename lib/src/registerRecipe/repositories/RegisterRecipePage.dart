import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myownmenu/models/Ingredient.dart';
import 'package:myownmenu/models/RecipeIngredient.dart';
import 'package:myownmenu/models/Step.dart' as RecipeStep;
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/service/IngredientService.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';
import 'package:myownmenu/utils/Helper.dart';

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
  TextEditingController _timeController = TextEditingController();
  TextEditingController _ingredientController = TextEditingController();
  TextEditingController _prepareModeController = TextEditingController();
  List<Ingredient> listIngredients = [];
  List<RecipeIngredient> listIngredientsSelected = [];
  List<RecipeStep.Step> listPrepareMode = [];
  List<bool> listVisible = _getVisibility();
  bool _visibleIngredient = false;
  bool _visiblePrepareMode = false;
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _controllers = [];
  int _sequenceCounter = 0;

  Widget singleItemList(index, TextEditingController controllertxt) {
    return new Card(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
              padding: EdgeInsets.only(left: 10),
              width: 120,
              height: 40,
              child: new TextFormField(
                controller: controllertxt,
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  listIngredientsSelected[index].quantity = controllertxt.text;
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorsUtils.darkYellow),
                  ),
                ),
              )),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Column(
                children: [
                  new Padding(
                    padding: EdgeInsets.only(top: 10, right: 15, bottom: 5),
                    child: new Text(
                      listIngredientsSelected[index].ingredient.name,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
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
                      listIngredientsSelected.removeAt(index);
                    });
                  },
                  child: new Icon(
                    Icons.indeterminate_check_box,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  buildAsyncPage() {
    return SingleChildScrollView(
        child: FutureBuilder<List<Ingredient>>(
            future: IngredientService.getAll(),
            initialData: [],
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(
                    '>>>listIngredients: ' + listIngredients.length.toString());
                List<dynamic> ingredientsName = [];
                snapshot.data.forEach(
                    (ingredient) => ingredientsName.add(ingredient.getName()));
                ingredientsName = Helper.unique(ingredientsName);
                return new SingleChildScrollView(
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
                                  new Container(
                                    padding: EdgeInsets.only(top: 30.0),
                                    child: new TextFormField(
                                      validator: (value) {
                                        if (_timeController.text.isEmpty) {
                                          return 'Campo Obrigatório!';
                                        }
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]"))
                                      ],
                                      controller: _timeController,
                                      decoration: new InputDecoration(
                                        labelText: 'Tempo (minutos)',
                                        border: new OutlineInputBorder(),
                                        suffixIcon: new Icon(
                                          Icons.timer,
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
                                            if (listIngredientsSelected
                                                .isEmpty) {
                                              return 'Campo Obrigatório!';
                                            }
                                          },
                                          controller: _ingredientController,
                                          decoration: new InputDecoration(
                                            labelText: 'Ingrediente',
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
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  'O valor inserido não pode ser vazio!')),
                                                        );
                                                      } else if (((_ingredientController
                                                                  .text !=
                                                              null) &&
                                                          ((!ingredientsName.contains(
                                                              _ingredientController
                                                                  .text))))) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'O ingrediente não existe!')),
                                                        );
                                                      } else {
                                                        print(
                                                            'listIngredients: ' +
                                                                listIngredients
                                                                    .length
                                                                    .toString());
                                                        // print(
                                                        //     'listIngredients: ' +
                                                        //         listIngredients[
                                                        //                 0]
                                                        //             .toJson()
                                                        //             .toString());
                                                        for (var ingredient
                                                            in listIngredients) {
                                                          if (ingredient.name ==
                                                              _ingredientController
                                                                  .text) {
                                                            Ingredient
                                                                newIngredient =
                                                                listIngredients
                                                                    .elementAt(listIngredients
                                                                        .indexOf(
                                                                            ingredient));
                                                            Type newType =
                                                                newIngredient
                                                                    .type;
                                                            RecipeIngredient
                                                                newRecipeIngredient =
                                                                RecipeIngredient(
                                                                    newType,
                                                                    newIngredient,
                                                                    '');
                                                            listIngredientsSelected
                                                                .add(
                                                                    newRecipeIngredient);
                                                          }
                                                        }
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
                                          visible: listIngredientsSelected
                                              .isNotEmpty,
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
                                    child: new Container(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                listIngredientsSelected.length,
                                            itemBuilder: (context, index) {
                                              _controllers.add(
                                                  new TextEditingController());
                                              if (listIngredientsSelected
                                                  .isEmpty) {
                                                return CircularProgressIndicator();
                                              } else {
                                                return singleItemList(
                                                    index, _controllers[index]);
                                              }
                                            })),
                                  ),
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
                                                  if (_prepareModeController
                                                      .text.isEmpty) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'O valor inserido não pode ser vazio!')),
                                                    );
                                                  } else {
                                                    _sequenceCounter++;
                                                    listPrepareMode.add(
                                                        RecipeStep.Step(
                                                            _prepareModeController
                                                                .text,
                                                            _sequenceCounter));
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
                                                listPrepareMode
                                                    .cast<String>()
                                                    .length,
                                                (index) => new Card(
                                                      child: new Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          new Column(
                                                            children: [
                                                              new Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 10,
                                                                        right:
                                                                            15,
                                                                        bottom:
                                                                            5),
                                                                child: new Text(
                                                                  listPrepareMode[
                                                                          index]
                                                                      .description,
                                                                  style:
                                                                      new TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          new SizedBox(
                                                            height: 60,
                                                            child:
                                                                new ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  listPrepareMode
                                                                      .removeAt(
                                                                          index);
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
                                              if (!_formKey.currentState!
                                                  .validate()) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Verifique o formulário!')),
                                                );
                                              } else {
                                                try {
                                                  print('ingrediente: ' +
                                                      listIngredientsSelected
                                                          .first
                                                          .toJson()
                                                          .toString());
                                                  print(
                                                      "---------------------------");
                                                  print('tipo: ' +
                                                      listIngredientsSelected
                                                          .first.type
                                                          .toJson()
                                                          .toString());
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Salvo com sucesso!')),
                                                  );
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const RegisterRecipe()),
                                                  );
                                                } on FirebaseAuthException catch (error) {
                                                  print(error.code);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Erro! Tente mais tarde.')),
                                                  );
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
                ));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildAsyncPage());
  }
}

String? validate(String value) {
  if (value.isEmpty) {
    return "Campo obrigatório";
  }
  return null;
}

List<bool> _getVisibility() {
  List<dynamic> listIngredients = [];
  List<bool> listVisible = [];

  // ignore: unused_local_variable
  for (var ingredient in listIngredients) listVisible.add(true);
  return listVisible;
}
