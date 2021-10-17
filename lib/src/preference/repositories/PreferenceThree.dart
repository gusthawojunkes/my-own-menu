import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/preference/repositories/PreferenceFour.dart';
import 'package:myownmenu/src/preference/repositories/preferenceTwo.dart';

class PreferenceThree extends StatelessWidget {
  const PreferenceThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferências',
      debugShowCheckedModeBanner: false,
      home: PreferenceThreePage(),
    );
  }
}

class PreferenceThreePage extends StatefulWidget {
  const PreferenceThreePage({Key? key}) : super(key: key);

  @override
  _PreferenceThreePageState createState() => _PreferenceThreePageState();
}

class _PreferenceThreePageState extends State<PreferenceThreePage> {
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
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Container(
                        child: Column(
                          children: [
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: new Text(
                                    'Pular',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                  ),
                                  onPressed: () {
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
                              child: new Text(
                                'Minha receita favorita é',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            new Card(
                              color: Color.fromRGBO(196, 196, 196, 100),
                              child: new TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  labelText: 'Exemplo...',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PreferenceFour()),
                            );
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
