import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    var _username = 'Usuário';
    return Scaffold(
      body: Column(children: [
        new Container(
          child: Image.asset(
            './lib/assets/BackgroundTop.png',
            fit: BoxFit.fill,
          ),
        ),
        Text(
          'Olá, $_username',
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        Center(
          child: Column(
            children: <Widget> [
              Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey
              ),
              margin: const EdgeInsets.all(10.0),
              width: 48.0,
              height: 48.0,
              )
            ],
          ),
        ),
        Divider(
          height: 35,
          thickness: 2,
          indent: 20,
          endIndent: 20,
          color: Colors.grey,
        ),
      ]),
    );
  }
}
