import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/login/repositories/login_page.dart';
import 'package:myownmenu/src/register/repositories/register_page.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          './lib/assets/background_top.png',
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
          './lib/assets/background_bottom.png',
          fit: BoxFit.fill,
        ),
      ],
    )));
  }
}
