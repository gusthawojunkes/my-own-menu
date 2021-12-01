import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/models/Type.dart';
import 'package:myownmenu/service/TypeService.dart';
import 'package:myownmenu/src/registerType/repositories/RegisterTypeModule.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';
import 'package:myownmenu/src/welcome/repositories/WelcomePage.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

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
  List<dynamic> urlImages = [
    "2619347",
    "2619348",
    "2619351",
    "2619354",
    "2619357",
    "2619360",
    "2619363",
    "2619368",
    "2619373",
    "2619381",
    "2619384",
    "2619387",
    "2619391",
    "2619395",
    "2619397",
    "2619404",
    "2619407",
    "2619410",
    "2619412",
    "2619416",
    "2619418",
    "2619422",
    "2619426",
    "2619430",
    "2619437",
    "2619441",
    "2619445",
    "2619451",
    "2619455",
    "2619459",
    "2619463",
    "2619467",
    "2619471",
    "2619473",
    "2619475",
    "2619477",
    "2619481",
    "2619483",
    "2619487",
    "2619491",
    "2619495",
    "2619502",
    "2619509",
    "2619519",
    "2619523",
    "2619528",
    "2619515"
  ];
  String selectedImage = "";

  Widget cardImage(image, cardKey) {
    return FlipCard(
      key: cardKey,
      front: card(image),
      back: card(image),
      onFlip: () {
        setState(() {
          selectedImage = image;
          visbileImages = !visbileImages;
        });
      },
    );
  }

  Widget card(image) {
    return new Card(
      child: new Container(
        margin: EdgeInsets.all(20),
        child: Image.network(
          SourceUtils.TYPE_URL_SRC + image + ".png",
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
                                          return cardImage(urlImages[index],
                                              cardsKeys[index]);
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
                                        selectedImage != ""
                                            ? new Container(
                                                height: 80,
                                                margin:
                                                    EdgeInsets.only(bottom: 30),
                                                child: new Image.network(
                                                    SourceUtils.TYPE_URL_SRC +
                                                        selectedImage
                                                            .toString() +
                                                        ".png"))
                                            : new Text(
                                                "Falha em \ncarregar a imagem!")
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
