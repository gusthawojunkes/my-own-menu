import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/service/UserService.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/preference/repositories/PreferenceFour.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class PreferenceThree extends StatelessWidget {
  const PreferenceThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferências',
      theme: themeApp(),
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
  TextEditingController _receitaFavoritaController =
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
                child: Padding(
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
                              child: new Text(
                                'Minha receita favorita é',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            new Card(
                              child: new TextFormField(
                                controller: _receitaFavoritaController,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  labelText:
                                      'Espaguete carbonara, Churrasco...',
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
                                  _receitaFavoritaController.text;
                              AuthService auth = AuthService.getInstance();
                              if (auth.user != null) {
                                print(auth.user!.uid);
                                UserService.update(
                                    uid: auth.user!.uid,
                                    property: 'favorite-recipe-name',
                                    value: response);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PreferenceFour()),
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
