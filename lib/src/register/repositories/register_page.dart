import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/login/repositories/login_page.dart';
import 'package:myownmenu/src/welcome/repositories/welcome_page.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
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
                        MaterialPageRoute(
                            builder: (context) => const Welcome()),
                      );
                    },
                  ))),
        ),
      ],
    ));
  }
}
