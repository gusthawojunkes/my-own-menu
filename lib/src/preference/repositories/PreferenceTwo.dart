import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/service/UserService.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/preference/repositories/PreferenceThree.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class PreferenceTwo extends StatelessWidget {
  const PreferenceTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferências',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: PreferenceTwoPage(),
    );
  }
}

class PreferenceTwoPage extends StatefulWidget {
  const PreferenceTwoPage({Key? key}) : super(key: key);

  @override
  _PreferenceTwoPageState createState() => _PreferenceTwoPageState();
}

class _PreferenceTwoPageState extends State<PreferenceTwoPage> {
  TextEditingController _otherResponseController = new TextEditingController();
  List options = ['Massa', 'Carnes no geral', 'Grãos'];
  List<bool> checked = [false, false, false];

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
                    mainAxisSize: MainAxisSize.min,
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
                              child: new Text(
                                'Meu tipo de comida favorita é',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            new Container(
                                child: Column(
                              children: [
                                for (var i = 0; i < options.length; i++)
                                  new Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: new Card(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            onChanged: (bool? value) {
                                              setState(() {
                                                checked[i] = value!;
                                              });
                                            },
                                            value: checked[i],
                                          ),
                                          Text(
                                            options[i],
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                new Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: new Card(
                                    child: TextFormField(
                                      controller: _otherResponseController,
                                      decoration: InputDecoration(
                                        labelText: 'Outro? Qual?',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                      new Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Próxima'),
                          onPressed: () {
                            Map response = {
                              'other': _otherResponseController.text,
                              'Massa': checked[0],
                              'Carnes no geral': checked[1],
                              'Grãos': checked[2]
                            };
                            try {
                              AuthService auth = AuthService.getInstance();
                              if (auth.user != null) {
                                print(auth.user!.uid);
                                UserService.setIntoUser(
                                    uid: auth.user!.uid,
                                    property: 'research-level-two',
                                    value: response);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PreferenceThree()),
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
