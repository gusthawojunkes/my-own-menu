import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/register/repositories/RegisterPage.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  SourceUtils.BACKGROUND_TOP_SRC,
                  fit: BoxFit.fill,
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(SourceUtils.LOGO_SRC),
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
                                                builder: (context) =>
                                                    const Login()),
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
                                              builder: (context) =>
                                                  const Register()),
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
          Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  SourceUtils.BACKGROUND_BOTTOM_SRC,
                  fit: BoxFit.fill,
                ),
              )),
        ],
      )),
    ));
  }
}
