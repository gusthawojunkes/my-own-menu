import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/models/error/AuthException.dart';
import 'package:myownmenu/src/index/repositories/IndexPage.dart';
import 'package:myownmenu/src/preference/repositories/PreferenceStart.dart';
import 'package:myownmenu/src/register/repositories/RegisterModule.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      new Container(
          child: Column(children: [
        new Container(
          child: Padding(
            padding: EdgeInsets.only(top: 80, bottom: 30),
            child: Text(
              'Cadastro',
              style: TextStyle(color: Colors.black, fontSize: 26.0),
            ),
          ),
        ),
        new Container(
            child: Padding(
          padding: EdgeInsets.only(top: 10.0, right: 30, left: 30),
          child: TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.people,
              ),
            ),
          ),
        )),
        new Container(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, right: 30, left: 30),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.email,
                ),
              ),
            ),
          ),
        ),
        new Container(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, right: 30, left: 30),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.vpn_key,
                ),
              ),
            ),
          ),
        ),
        new Container(
            child: Padding(
                padding: EdgeInsets.only(top: 10.0, right: 30, left: 30),
                child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Confirme sua Senha',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.vpn_key,
                        ))))),
        new Padding(
          padding: EdgeInsets.only(top: 80),
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
                                RegisterModule.execute(
                                        _nameController.text,
                                        _emailController.text,
                                        _passwordController.text)
                                    .then((newUser) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PreferenceStart()),
                                        ))
                                    .catchError((error) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Algo deu errado na hora de realizar o cadastro, tente novamente mais tarde!')),
                                        ));
                              })))),
              new Container(
                child: Padding(
                    padding: EdgeInsets.only(right: 30, left: 30),
                    child: new Container(
                        width: double.infinity,
                        child: TextButton(
                          child: const Text('Voltar'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Index()),
                            );
                          },
                        ))),
              ),
            ],
          ),
        ),
      ]))
    ])));
  }
}
