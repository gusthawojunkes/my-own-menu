import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/service/ImageService.dart';
import 'package:myownmenu/service/StockService.dart';
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
  late XFile image;
  String imageUrl = "";
  buildAsyncPage() {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: TypeService.getAll(),
        initialData: [],
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            listFilters = snapshot.data;
            return Form(
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
                                      return 'Campo Obrigat??rio!';
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
                              // new Container(
                              //   padding: EdgeInsets.only(top: 30.0),
                              //   child: new TextFormField(
                              //     validator: (value) {
                              //       if (_quantityController.text.isEmpty) {
                              //         return 'Campo Obrigat??rio!';
                              //       }
                              //     },
                              //     controller: _quantityController,
                              //     decoration: new InputDecoration(
                              //       labelText: 'Quantidade',
                              //       border: new OutlineInputBorder(),
                              //       suffixIcon: new Icon(
                              //         Icons.align_vertical_bottom_sharp,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              new Container(
                                  padding: EdgeInsets.only(top: 30),
                                  width: double.infinity,
                                  child: TextButton(
                                      child: Text("Adionar imagem"),
                                      onPressed: () async {
                                        image =
                                            (await ImageService.getImage())!;
                                      })),
                              new Container(
                                  padding: EdgeInsets.only(top: 30),
                                  width: double.infinity,
                                  child: TextButton(
                                      child: Text(selectedType == ""
                                          ? 'Adicionar Tipo'
                                          : 'Trocar Tipo'),
                                      onPressed: () async {
                                        // print('imageUrl: ' + imageUrl);
                                        // imageUrl =
                                        //     await FileServive.downloadFile(
                                        //         "/ingredients/Abacaxi/");
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
                                                  (BuildContext context,
                                                      int index) {
                                                cardsKeys.add(new GlobalKey<
                                                    FlipCardState>());
                                                return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        visbileType =
                                                            !visbileType;
                                                        nameSelectedType =
                                                            listFilters[index]
                                                                .name;
                                                        selectedType =
                                                            listFilters[index]
                                                                .image;
                                                      });
                                                    },
                                                    child: Card(
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
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
                                                                  listFilters[
                                                                          index]
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
                                                          SourceUtils
                                                                  .TYPE_URL_SRC +
                                                              selectedType +
                                                              ".png",
                                                          height: 60,
                                                        ),
                                                        new Text(
                                                            nameSelectedType),
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
                        top: visbileType || selectedType != "" ? 0 : 100,
                        right: 30,
                        left: 30),
                    child: Column(
                      children: [
                        new Container(
                            child: new Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    child: const Text('Cadastrar'),
                                    onPressed: () async {
                                      if (!_formKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Verifique o formul??rio!')),
                                        );
                                      } else if (selectedType == "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Selecione um tipo!')),
                                        );
                                      } else {
                                        try {
                                          String nameUser =
                                              _nameController.text;
                                          Type type = new Type(
                                              nameSelectedType, selectedType);
                                          // await StockService.saveImage(
                                          //     image: image,
                                          //     name: _nameController.text);
                                          // await ImageService.downloadFile(
                                          //     "/ingredients/" + nameUser);
                                          await StockService.create(
                                              name: nameUser,
                                              type: type);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Salvo com sucesso!')),
                                          );
                                          setState(() {
                                            selectedType = "";
                                            nameSelectedType = "";
                                            _nameController.text = "";
                                          });
                                        } on FirebaseAuthException catch (error) {
                                          print(error.code);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Algo deu errado!\n Tente novamente')),
                                          );
                                        }
                                      }
                                    }))),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAsyncPage(),
    );
  }
}
