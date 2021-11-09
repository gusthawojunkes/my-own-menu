import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class Objective extends StatelessWidget {
  const Objective({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Objective',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: ObjectivePage(),
    );
  }
}

class ObjectivePage extends StatefulWidget {
  const ObjectivePage({Key? key}) : super(key: key);

  @override
  _ObjectivePageState createState() => _ObjectivePageState();
}

class _ObjectivePageState extends State<ObjectivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
