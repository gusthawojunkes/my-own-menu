import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Configuration extends StatelessWidget {
  const Configuration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      theme: ThemeData.fallback(),
      debugShowCheckedModeBanner: false,
      home: ConfigurationPage(),
    );
  }
}

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool _darkMode = false;
  bool _notification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: new Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      new Container(
                        child: Column(
                          children: [
                            new Row(
                              children: [
                                new Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'Configurações',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  ),
                                )
                              ],
                            ),
                            new Card(
                              child: new Container(
                                color: Color.fromRGBO(219, 219, 219, 100),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    new Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, right: 15, bottom: 5),
                                      child: new Text(
                                        'Média de refeições\n diárias',
                                        textAlign: TextAlign.right,
                                        style: new TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    new Container(
                                        color:
                                            Color.fromRGBO(156, 156, 156, 100),
                                        child: new Padding(
                                            padding: EdgeInsets.all(30),
                                            child: new Text(
                                              '3',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new ListTile(
                        title: Text('Modo Escuro'),
                        leading: Switch(
                          value: _darkMode,
                          onChanged: (bool value) {
                            setState(() {
                              _darkMode = !_darkMode;
                            });
                          },
                        ),
                      ),
                      new Divider(
                        color: Colors.black,
                      ),
                      new ListTile(
                        title: Text('Notificações'),
                        leading: Switch(
                          value: _notification,
                          onChanged: (bool value) {
                            setState(() {
                              _notification = !_notification;
                            });
                          },
                        ),
                      ),
                      new Divider(
                        color: Colors.black,
                      ),
                      new ListTile(
                          title: Text('Sobre'),
                          leading: TextButton(
                            child: const Icon(Icons.info_rounded,
                                color: Colors.black),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Sobre'),
                                  content: const Text(
                                      "Este projeto tem como base a aplicabilidade e estudo das matérias e conhecimentos referentes ao quarto semestre da graduação. Nesse sentido, o seu desenvolvimento vem de encontro com a necessidade de aplicar conteúdos de forma real com a usabilidade e entrega de um produto concreto.  "),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    ],
                  ))));
    }));
  }
}
