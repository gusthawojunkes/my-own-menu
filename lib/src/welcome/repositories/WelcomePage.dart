import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myownmenu/src/home/repositories/HomePage.dart';
import 'package:myownmenu/utils/SourceUtils.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: themeApp(),
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
    AuthService auth = AuthService();
    String? _userDisplayName = 'Usuário';
    if (auth.user != null && auth.user!.displayName != null) {
      _userDisplayName = auth.user!.displayName;
    }
    String notificationsJson =
        '{"notifications":[{"description":"Refeições realizadas hoje","statistic":"2/2"},{"description":"Refeições realizadas ontem","statistic":"2/3"},{"description":"Refeições programadas para a amanhã","statistic":"0/1"},{"description":"Copos de água ingeridos","statistic":"2/5"},{"description":"Idas ao mercado","statistic":"5/5"}]}';
    Map<String, dynamic> mapNotifications = jsonDecode(notificationsJson);
    List<dynamic> listNotifications = mapNotifications['notifications'];

    Widget notification(int sequenceNotification) {
      return Container(
        width: 150,
        height: 170,
        child: Card(
            clipBehavior: Clip.antiAlias,
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 10, left: 5, bottom: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15, right: 15, left: 15, bottom: 10),
                        child: Text(
                          listNotifications[sequenceNotification]['statistic'],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 5, right: 15, left: 15, bottom: 15),
                        child: Text(
                          listNotifications[sequenceNotification]
                              ['description'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ))),
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: new Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(SourceUtils.BACK_TOP_SRC),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth)),
                child: new Column(
                  children: [
                    new Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 30, left: 30),
                            child: new Text(
                              'Olá, $_userDisplayName',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ))
                      ],
                    ),
                    new Container(
                        padding: EdgeInsets.all(30),
                        child: new Column(
                          children: [
                            new Container(
                              height: 80,
                              width: double.infinity,
                              child: new Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(page: 7)),
                                    );
                                  },
                                  child: new Align(
                                      alignment: Alignment.centerLeft,
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.fastfood),
                                          new Text("Cadastro de Receita")
                                        ],
                                      )),
                                ),
                              ),
                            ),
                            new Container(
                              height: 80,
                              width: double.infinity,
                              child: new Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(page: 8)),
                                    );
                                  },
                                  child: new Align(
                                      alignment: Alignment.centerLeft,
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.coffee),
                                          new Text("Cadastro de Ingredientes")
                                        ],
                                      )),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Divider(
                      height: 35,
                      thickness: 2,
                      indent: 30,
                      endIndent: 30,
                    ),
                    new Container(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new Text(
                                'Objetivos',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18),
                              ),
                              new ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(page: 9)),
                                    );
                                  },
                                  child: Icon(Icons.plus_one))
                            ])),
                    Container(
                      margin: const EdgeInsets.only(right: 30, left: 30),
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(listNotifications.length,
                              (sequenceNotification) {
                            return notification(sequenceNotification);
                          }),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
