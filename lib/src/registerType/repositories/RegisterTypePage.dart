import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/service/TypeService.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';
import 'package:myownmenu/src/welcome/repositories/WelcomePage.dart';

class RegisterType extends StatelessWidget {
  const RegisterType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Tipo de Ingrediente',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: RegisterTypePage(),
    );
  }
}

class RegisterTypePage extends StatefulWidget {
  const RegisterTypePage({Key? key}) : super(key: key);

  @override
  _RegisterTypePageState createState() => _RegisterTypePageState();
}

class _RegisterTypePageState extends State<RegisterTypePage> {
  TextEditingController _nameController = TextEditingController();
  List<GlobalKey<FlipCardState>> cardsKeys = [];

  final _formKey = GlobalKey<FormState>();
  bool visbileImages = false;
  List<String> urlImages = [
    'https://cdn-icons-png.flaticon.com/512/2619/2619347.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619348.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619351.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619354.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619357.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619360.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619363.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619368.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619373.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619381.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619384.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619387.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619391.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619395.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619397.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619404.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619407.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619410.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619412.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619416.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619418.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619422.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619426.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619430.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619437.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619441.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619445.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619451.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619455.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619459.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619463.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619467.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619471.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619473.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619475.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619477.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619481.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619483.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619487.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619491.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619495.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619502.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619509.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619519.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619523.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619528.png',
    'https://cdn-icons-png.flaticon.com/512/2619/2619515.png',
  ];
  String selectedImage = "";

  Widget cardImage(index, cardKey) {
    return FlipCard(
      key: cardKey,
      front: card(index),
      back: card(index),
      onFlip: () {
        setState(() {
          selectedImage = urlImages[index];
          visbileImages = !visbileImages;
        });
      },
    );
  }

  Widget card(index) {
    return new Card(
      child: new Container(
        margin: EdgeInsets.all(20),
        child: Image.network(
          urlImages[index],
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
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
                          'Cadastro de Tipo de \nIngrediente',
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
                                Icons.create,
                              ),
                            ),
                          ),
                        )),
                        new Container(
                            padding: EdgeInsets.only(top: 30),
                            width: double.infinity,
                            child: TextButton(
                                child: Text(selectedImage == ""
                                    ? 'Adicionar Imagem'
                                    : 'Trocar Imagem'),
                                onPressed: () {
                                  setState(() {
                                    visbileImages = !visbileImages;
                                  });
                                })),
                        new Visibility(
                            visible: visbileImages,
                            child: new SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: new Container(
                                    height: 100,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: urlImages.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          cardsKeys.add(
                                              new GlobalKey<FlipCardState>());
                                          return cardImage(
                                              index, cardsKeys[index]);
                                        })))),
                        new Visibility(
                            visible: (selectedImage != "") ? true : false,
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
                                            height: 80,
                                            margin: EdgeInsets.only(bottom: 30),
                                            child: new Image.network(
                                                selectedImage))
                                      ])),
                            ))
                      ],
                    )
                  ],
                )),
            new Padding(
              padding: EdgeInsets.only(
                  top: visbileImages || (selectedImage != "") ? 0 : 130,
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
                                } else if (selectedImage == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Selecione uma imagem!')),
                                  );
                                } else {
                                  try {
                                    TypeService.create(
                                        name: _nameController.text,
                                        image: selectedImage);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Salvo com sucesso!')),
                                    );
                                    setState(() {
                                      selectedImage = "";
                                      _nameController.text = "";
                                    });
                                  } on FirebaseAuthException catch (error) {
                                    print(error.code);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Erro! Tente mais tarde.')),
                                    );
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
