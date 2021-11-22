import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myownmenu/service/UserService.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/preference/repositories/PreferenceEnd.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class PreferenceFour extends StatelessWidget {
  const PreferenceFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferências',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: PreferenceFourPage(),
    );
  }
}

class PreferenceFourPage extends StatefulWidget {
  const PreferenceFourPage({Key? key}) : super(key: key);

  @override
  _PreferenceFourPageState createState() => _PreferenceFourPageState();
}

class _PreferenceFourPageState extends State<PreferenceFourPage> {
  TextEditingController _quantidadeRefeicoesController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: new Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Container(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: new Text(
                                    'Pular',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()),
                                    );
                                  },
                                )
                              ],
                            ),
                            new Padding(
                              padding: EdgeInsets.only(top: 30, bottom: 30),
                              child: Text(
                                'Minha média de refeiçoes é',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            new Card(
                              child: new TextFormField(
                                controller: _quantidadeRefeicoesController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Ex: 3, 4',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Próxima'),
                          onPressed: () {
                            try {
                              dynamic response =
                                  _quantidadeRefeicoesController.text;
                              AuthService auth = AuthService.getInstance();
                              if (auth.user != null) {
                                print(auth.user!.uid);
                                UserService.setIntoUser(
                                    uid: auth.user!.uid,
                                    property: 'research-level-four',
                                    value: response);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PreferenceEnd()),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
