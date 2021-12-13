import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myownmenu/models/error/AuthException.dart';
import 'package:myownmenu/utils/EmailUtils.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';
import 'package:myownmenu/src/home/repositories/HomePage.dart';
import 'package:myownmenu/src/index/repositories/IndexPage.dart';
import 'package:myownmenu/src/login/repositories/LoginModule.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            new Container(
              child: Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Text(
                    'Login',
                    style:
                        TextStyle(color: ColorsUtils.darkBlue, fontSize: 26.0),
                  )),
            ),
            new Container(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0, right: 30, left: 30),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.email,
                      // color: ColorsUtils.darkBlue,
                    ),
                  ),
                  validator: (input) {
                    if (EmailUtils.isNotValid(input)) {
                      return 'Preencha com um e-mail válido';
                    }
                  },
                ),
              ),
            ),
            new Container(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, right: 30, left: 30),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.vpn_key,
                      // color: ColorsUtils.darkBlue,
                    ),
                  ),
                  validator: (input) {
                    if (input == null) {
                      return 'Preencha com a sua senha';
                    }
                  },
                ),
              ),
            ),
            new Container(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, left: 30),
                child: new Container(
                  child: Align(
                      alignment: FractionalOffset.topLeft,
                      child: GestureDetector(
                          child: Text("Esqueceu sua senha?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: ColorsUtils.darkBlue)),
                          onTap: () {})),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: Column(children: [
                new Container(
                    child: Padding(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  child: new Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text('Entrar'),
                        onPressed: () {
                          try {
                            LoginModule.execute(_emailController.text,
                                    _passwordController.text)
                                .then((user) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()),
                                    ));
                          } on FirebaseAuthException catch (e) {
                            print(e);
                             ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text( 
                                      'Algo deu errado na hora de realizar o login, tente novamente mais tarde!')),
                            );
                          } on AuthException catch (ex) {
                            print(ex);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Algo deu errado na hora de realizar o login, tente novamente mais tarde!')),
                            );
                          } catch (error) {
                            print(error);
                          }
                        },
                      )),
                )),
              ]),
            ),
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
    );
  }
}
