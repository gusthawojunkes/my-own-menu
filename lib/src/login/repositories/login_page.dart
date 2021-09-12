import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/home/repositories/home_page.dart';
import 'package:myownmenu/src/welcome/repositories/welcome_page.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        new Container(
          child: Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.black, fontSize: 26.0),
              )),
        ),
        new Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0, right: 30, left: 30),
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
            padding: EdgeInsets.only(top: 30.0, left: 30),
            child: new Container(
              child: Align(
                  alignment: FractionalOffset.topLeft,
                  child: GestureDetector(
                      child: Text("Esqueçeu sua senha?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue)),
                      onTap: () {
                        // do what you need to do when "Click here" gets clicked
                      })),
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
                      child: const Text('Entrar'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
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
