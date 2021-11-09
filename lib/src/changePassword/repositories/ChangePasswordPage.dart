import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/profile/repositories/ProfilePage.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alteração de Senha',
      debugShowCheckedModeBanner: false,
      home: ChangePasswordPage(),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

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
                          'Alteração de Senha',
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
                            obscureText: true,
                            validator: (value) {
                              if (_oldPasswordController.text.isEmpty) {
                                return 'Campo Obrigatório!';
                              }
                            },
                            controller: _oldPasswordController,
                            decoration: new InputDecoration(
                              labelText: 'Senha Antiga',
                              border: new OutlineInputBorder(),
                              suffixIcon: new Icon(
                                Icons.vpn_key,
                              ),
                            ),
                          ),
                        )),
                        new Container(
                            child: Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: new TextFormField(
                            validator: (value) {
                              if (_newPasswordController.text.isEmpty) {
                                return 'Campo Obrigatório!';
                              }
                            },
                            controller: _newPasswordController,
                            decoration: new InputDecoration(
                              labelText: 'Nova Senha',
                              border: new OutlineInputBorder(),
                              suffixIcon: new Icon(
                                Icons.vpn_key,
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
            ),
          ],
        ),
      )),
    );
  }
}
