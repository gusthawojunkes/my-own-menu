import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Configuration extends StatelessWidget {
  const Configuration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        new Container(
          child: Image.asset(
            './lib/assets/BackgroundTop.png',
            fit: BoxFit.fill,
          ),
        ),
      ]),
    );
  }
}
