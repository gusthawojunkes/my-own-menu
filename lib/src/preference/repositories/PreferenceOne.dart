import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/preference/repositories/PreferenceTwo.dart';

class PreferenceOne extends StatelessWidget {
  const PreferenceOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferências',
      debugShowCheckedModeBanner: false,
      home: PreferenceOnePage(),
    );
  }
}

class PreferenceOnePage extends StatefulWidget {
  const PreferenceOnePage({Key? key}) : super(key: key);

  @override
  _PreferenceOnePageState createState() => _PreferenceOnePageState();
}

class _PreferenceOnePageState extends State<PreferenceOnePage> {
  int _value = 1;
  List options = ['Sim', 'Não', 'Prefiro não responder'];

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
                                'Você ingere algum tipo de carne?',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            new Column(
                              children: <Widget>[
                                for (int i = 0; i <= options.length - 1; i++)
                                  new Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: new Card(
                                      color: Color.fromRGBO(196, 196, 196, 100),
                                      child: ListTile(
                                        title: Text(
                                          options[i],
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(color: Colors.black),
                                        ),
                                        leading: Radio(
                                          value: i,
                                          groupValue: _value,
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              _value = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
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
                                  builder: (context) => const PreferenceTwo()),
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
