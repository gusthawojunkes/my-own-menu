import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Objective extends StatelessWidget {
  const Objective({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Objective',
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
    return Scaffold(
      body: Container()
    );
  }
}
