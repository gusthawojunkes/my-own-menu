import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/register/repositories/RegisterPage.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          './lib/assets/BackgroundTop.png',
          fit: BoxFit.fill,
        ),
        Image.asset('./lib/assets/LogoTemporaria.png'),
        new Container(
          child: Column(
            children: [
              new Container(
                child: Padding(
                    padding: EdgeInsets.only(right: 30, left: 30),
                    child: new Container(
                      width: double.infinity,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            child: const Text('Login'),
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
                    padding: EdgeInsets.only(right: 30, left: 30),
                    child: new Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Cadastro'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()),
                            );
                          },
                        ))),
              ),
            ],
          ),
        ),
        Image.asset(
          './lib/assets/BackgroundBottom.png',
          fit: BoxFit.fill,
        ),
      ],
    )));
  }
}
