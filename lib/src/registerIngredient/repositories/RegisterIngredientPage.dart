import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/service/IngredientService.dart';
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
  TextEditingController _typeController = TextEditingController();
  List<GlobalKey<FlipCardState>> cardsKeys = [];
  final _formKey = GlobalKey<FormState>();
  bool visbileType = false;
  String selectedType = "";

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
                                        itemCount: 10,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          cardsKeys.add(
                                              new GlobalKey<FlipCardState>());
                                          return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectedType = "teste";
                                                  visbileType = !visbileType;
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
                                                            'https://cdn-icons-png.flaticon.com/512/2619/2619347.png',
                                                            height: 60,
                                                          ),
                                                          Text(
                                                            "Teste",
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
                            visible: (selectedType != "") ? true : false,
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
                                        new Container(
                                            // width: double.infinity,
                                            padding: EdgeInsets.only(
                                                top: 30, bottom: 30),
                                            //O que tem que fazer
                                            //merge da master na branch
                                            //relacionar o tipo com o ingrediente

                                            //obter os urls do storage para deixar dinamico a tela de tipos

                                            //deixar dinamico os filtros das tela que os tem!!!
                                            child: Column(children: [
                                              new Image.network(
                                                'https://cdn-icons-png.flaticon.com/512/2619/2619347.png',
                                                height: 60,
                                              ),
                                              new Text("Teste"),
                                            ])),
                                      ])),
                            ))
                      ],
                    )
                  ],
                )),
            new Padding(
              padding: EdgeInsets.only(
                  top: visbileType || (selectedType != "") ? 0 : 130,
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
                                    IngredientService.create(
                                        name: _nameController.text,
                                        type: _typeController.text);
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
