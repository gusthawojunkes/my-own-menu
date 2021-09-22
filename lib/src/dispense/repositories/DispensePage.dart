import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dispense extends StatelessWidget {
  const Dispense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      debugShowCheckedModeBanner: false,
      home: DispensePage(),
    );
  }
}

class DispensePage extends StatefulWidget {
  const DispensePage({Key? key}) : super(key: key);

  @override
  _DispensePageState createState() => _DispensePageState();
}

class _DispensePageState extends State<DispensePage> {
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
