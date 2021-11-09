import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class PreferenceEnd extends StatelessWidget {
  const PreferenceEnd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferências, Tudo certo!',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: PreferenceEndPage(),
    );
  }
}

class PreferenceEndPage extends StatefulWidget {
  const PreferenceEndPage({Key? key}) : super(key: key);

  @override
  _PreferenceEndPageState createState() => _PreferenceEndPageState();
}

class _PreferenceEndPageState extends State<PreferenceEndPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              'Tudo Pronto!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          SizedBox(
            width: 270,
            child: Text(
              'Muito obrigado!\n\n Agradeçemos o seu tempo e dedicação para nos informar sobre suas \npreferências!',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          new Container(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text('Finalizar'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
