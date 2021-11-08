import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/service/IngredientService.dart';
import 'package:myownmenu/src/admin/repositories/AdminPage.dart';

class RegisterIngredient extends StatelessWidget {
  const RegisterIngredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Ingrediente',
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
  TextEditingController _quantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                padding: EdgeInsets.only(left: 30, bottom: 30, right: 30),
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
                            child: Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: new TextFormField(
                            validator: (value) {
                              if (_typeController.text.isEmpty) {
                                return 'Campo Obrigatório!';
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
                        )),
                        new Container(
                            child: Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: new TextFormField(
                            validator: (value) {
                              if (_quantityController.text.isEmpty) {
                                return 'Campo Obrigatório!';
                              }
                            },
                            controller: _quantityController,
                            decoration: new InputDecoration(
                              labelText: 'Quantidade',
                              border: new OutlineInputBorder(),
                              suffixIcon: new Icon(
                                Icons.format_list_numbered,
                              ),
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                )),
            new Padding(
              padding: EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  new Container(
                      child: Padding(
                          padding: EdgeInsets.only(right: 30, left: 30),
                          child: new Container(
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
                                        IngredientService.create(
                                            name: _nameController.text,
                                            type: _typeController.text,
                                            quantity: _quantityController.text);
                                      } on FirebaseAuthException catch (error) {
                                        print(error.code);
                                      }
                                    }
                                  })))),
                  new Container(
                    child: Padding(
                        padding: EdgeInsets.only(right: 30, left: 30),
                        child: new Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: const Text('Voltar'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Admin()),
                                );
                              },
                            ))),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
