import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notification extends StatelessWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      debugShowCheckedModeBanner: false,
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
