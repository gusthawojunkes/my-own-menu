import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myownmenu/src/admin/repositories/AdminPage.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class RegisterGoal extends StatelessWidget {
  const RegisterGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Goale',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: RegisterGoalPage(),
    );
  }
}

class RegisterGoalPage extends StatefulWidget {
  const RegisterGoalPage({Key? key}) : super(key: key);

  @override
  _RegisterGoalPageState createState() => _RegisterGoalPageState();
}

class _RegisterGoalPageState extends State<RegisterGoalPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
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
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    new Row(
                      children: [
                        new Text(
                          'Cadastro de Objetivo',
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
                            child: Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: new TextFormField(
                            validator: (value) {
                              if (_typeController.text.isEmpty) {
                                return 'Campo Obrigatório!';
                              }
                            },
                            controller: _typeController,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            decoration: new InputDecoration(
                              labelText: 'Meta',
                              border: new OutlineInputBorder(),
                              suffixIcon: new Icon(
                                Icons.bar_chart,
                              ),
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                )),
            new Padding(
              padding: EdgeInsets.only(top: 130, right: 30, left: 30),
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
                                } else {
                                  try {} on FirebaseAuthException catch (error) {
                                    print(error.code);
                                  }
                                }
                              }))),
                  new Container(
                    child: new Container(
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
                        )),
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
