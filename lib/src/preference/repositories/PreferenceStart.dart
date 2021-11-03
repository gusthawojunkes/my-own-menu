import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/preference/repositories/PreferenceOne.dart';

class PreferenceStart extends StatelessWidget {
  const PreferenceStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferências, Bem Vindo',
      debugShowCheckedModeBanner: false,
      home: PreferenceStartPage(),
    );
  }
}

class PreferenceStartPage extends StatefulWidget {
  const PreferenceStartPage({Key? key}) : super(key: key);

  @override
  _PreferenceStartPageState createState() => _PreferenceStartPageState();
}

class _PreferenceStartPageState extends State<PreferenceStartPage> {
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
              'Seja bem-vindo(a)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          SizedBox(
            width: 270,
            child: Text(
              'Para começar bem, conte-nos algumas de suas preferências...',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          new Container(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text('Continuar'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PreferenceOne()),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
