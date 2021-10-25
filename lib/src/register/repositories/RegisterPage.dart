import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/index/repositories/IndexPage.dart';
import 'package:myownmenu/src/register/repositories/RegisterModule.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
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
        body: Column(
      children: [
        new Container(
          child: Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Text(
                'Cadastro',
                style: TextStyle(color: Colors.black, fontSize: 26.0),
              )),
        ),
        new Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0, right: 30, left: 30),
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
          ),
        ),
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
                ),
              ),
            ),
          ),
        ),
        new Container(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, right: 30, left: 30),
              child: new Container(
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: ElevatedButton(
                      child: const Text('Cadastrar'),
                      onPressed: () {
                        try {
                          RegisterModule.register(_nameController.text,
                              _emailController.text, _passwordController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        } on FirebaseAuthException catch (error) {
                          print(error.code);
                        }
                      },
                    )),
              )),
        ),
        new Container(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, right: 30, left: 30),
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
                        MaterialPageRoute(builder: (context) => const Index()),
                      );
                    },
                  ))),
        ),
      ],
    ));
  }
}
