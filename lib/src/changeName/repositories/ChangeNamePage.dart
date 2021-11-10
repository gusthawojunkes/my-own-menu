import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myownmenu/src/profile/repositories/ProfilePage.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alteração de Nome',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: ChangeNamePage(),
    );
  }
}

class ChangeNamePage extends StatefulWidget {
  const ChangeNamePage({Key? key}) : super(key: key);

  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  TextEditingController _newNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SingleChildScrollView(
          child: new Form(
        key: _formKey,
        child: new Column(
          children: [
            new Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    new Row(
                      children: [
                        new Text(
                          'Alteração de Nome',
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
                              if (_newNameController.text.isEmpty) {
                                return 'Campo Obrigatório!';
                              }
                            },
                            controller: _newNameController,
                            decoration: new InputDecoration(
                              labelText: 'Novo Nome',
                              border: new OutlineInputBorder(),
                              suffixIcon: new Icon(
                                Icons.people,
                              ),
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                )),
            new Column(
              children: [
                new Container(
                    padding: EdgeInsets.only(top: 200),
                    child: Padding(
                        padding: EdgeInsets.only(right: 30, left: 30),
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
                                  } else {
                                    try {} on FirebaseAuthException catch (error) {
                                      print(error.code);
                                    }
                                  }
                                })))),
                new Container(
                  child: Padding(
                      padding: EdgeInsets.only(right: 30, left: 30),
                      child: new Container(
                          width: double.infinity,
                          child: TextButton(
                            child: const Text('Voltar'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Profile()),
                              );
                            },
                          ))),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
