import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/service/IngredientService.dart';
import 'package:myownmenu/service/TypeService.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

class RegisterIngredient extends StatelessWidget {
  const RegisterIngredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Ingrediente',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: RegisterIngredientPage(),
    );
  }
}

class RegisterIngredientPage extends StatefulWidget {
  const RegisterIngredientPage({Key? key}) : super(key: key);

  @override
  _RegisterIngredientPageState createState() => _RegisterIngredientPageState();
}

class _RegisterIngredientPageState extends State<RegisterIngredientPage> {
  TextEditingController _nameController = TextEditingController();
  List<GlobalKey<FlipCardState>> cardsKeys = [];
  final _formKey = GlobalKey<FormState>();
  bool visbileType = false;
  String selectedType = "";
  List listFilters = [];
  String nameSelectedType = "";

  @override
  // ignore: must_call_super
  initState() {
    startAsyncInit();
  }

  Future startAsyncInit() async {
    setState(() async {
      listFilters = await TypeService.getAll();
      print("listFilters: " + listFilters.toString());
    });
  }

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
                          'Cadastro de Ingrediente',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 24.0),
                        )
                      ],
                    ),
                    new Column(
                      children: [
                        new Container(
                            child: Padding(
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
                        )),
                        new Container(
                            padding: EdgeInsets.only(top: 30),
                            width: double.infinity,
                            child: TextButton(
                                child: Text(selectedType == ""
                                    ? 'Adicionar Tipo'
                                    : 'Trocar Tipo'),
                                onPressed: () {
                                  setState(() {
                                    visbileType = !visbileType;
                                  });
                                })),
                        new Visibility(
                            visible: visbileType,
                            child: new SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: new Container(
                                    height: 170,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: listFilters.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          cardsKeys.add(
                                              new GlobalKey<FlipCardState>());
                                          return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  visbileType = !visbileType;
                                                  nameSelectedType =
                                                      listFilters[index].name;
                                                  selectedType =
                                                      listFilters[index].image;
                                                });
                                              },
                                              child: Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16,
                                                              left: 16,
                                                              right: 16),
                                                      child: Column(
                                                        children: [
                                                          Image.network(
                                                            SourceUtils
                                                                    .TYPE_URL_SRC +
                                                                listFilters[
                                                                        index]
                                                                    .image +
                                                                ".png",
                                                            height: 60,
                                                          ),
                                                          Text(
                                                            listFilters[index]
                                                                .name,
                                                            style: TextStyle(
                                                                height: 4,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ))));
                                        })))),
                        new Visibility(
                            visible: selectedType != "" ? true : false,
                            child: new Card(
                              child: new Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 30, left: 30, right: 30),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        new Text("Selecionado: "),
                                        selectedType != ""
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    top: 30, bottom: 30),
                                                child: Column(children: [
                                                  new Image.network(
                                                    SourceUtils.TYPE_URL_SRC +
                                                        selectedType +
                                                        ".png",
                                                    height: 60,
                                                  ),
                                                  new Text(nameSelectedType),
                                                ]))
                                            : Text(''),
                                      ])),
                            ))
                      ],
                    )
                  ],
                )),
            new Padding(
              padding: EdgeInsets.only(
                  top: visbileType || selectedType != "" ? 0 : 130,
                  right: 30,
                  left: 30),
              child: Column(
                children: [
                  new Container(
                      child: new Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              child: const Text('Cadastrar'),
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Verifique o formulário!')),
                                  );
                                } else if (selectedType == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Selecione um tipo!')),
                                  );
                                } else {
                                  try {
                                    Map type = {
                                      'name': nameSelectedType,
                                      'image': selectedType
                                    };
                                    IngredientService.create(
                                        name: _nameController.text, type: type);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Salvo com sucesso!')),
                                    );
                                    setState(() {
                                      selectedType = "";
                                      nameSelectedType = "";
                                      _nameController.text = "";
                                    });
                                  } on FirebaseAuthException catch (error) {
                                    print(error.code);
                                  }
                                }
                              }))),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
