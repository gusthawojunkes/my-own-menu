import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/models/Step.dart' as RecipeStep;
import 'package:myownmenu/src/admin/repositories/AdminPage.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

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
  late List<String> listIngredients = [];
  late List<RecipeStep.Step> listPrepareMode = [];
  bool _visibleIngredient = false;
  bool _visiblePrepareMode = false;
  final _formKey = GlobalKey<FormState>();
  int _sequenceCounter = 0;

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
                        new Container(
                          padding: EdgeInsets.only(top: 30.0),
                          child: new TextFormField(
                            validator: (value) {
                              if (_nameController.text.isEmpty) {
                                return 'Tipo: Campo Obrigatório!';
                              }
                            },
                            controller: _typeController,
                            decoration: new InputDecoration(
                              labelText: 'Tipo',
                              border: new OutlineInputBorder(),
                              suffixIcon: new Icon(
                                Icons.label,
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
                                          listIngredients
                                              .add(_ingredientController.text);
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
                                      listIngredients.length,
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
                                                        listIngredients[index],
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
                                                        listIngredients
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
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'O valor inserido não pode ser vazio!')),
                                          );
                                        } else {
                                          _sequenceCounter++;
                                          listPrepareMode.add(RecipeStep.Step(
                                              description:
                                                  _prepareModeController.text,
                                              sequence: _sequenceCounter));
                                          print(listPrepareMode);
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
                                      listPrepareMode.cast<String>().length,
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
                                                        listPrepareMode[index]
                                                            .description,
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
                        new Container(
                          padding: EdgeInsets.only(top: 30.0),
                          child: new TextFormField(
                            maxLines: 4,
                            controller: _additionalInformationsController,
                            decoration: new InputDecoration(
                              labelText: 'informações Adiconais',
                              border: new OutlineInputBorder(),
                              suffixIcon: new Icon(
                                Icons.info,
                              ),
                            ),
                          ),
                        ),
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
                          new Container(
                              width: double.infinity,
                              child: TextButton(
                                child: const Text('Voltar'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Admin()),
                                  );
                                },
                              ))
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
