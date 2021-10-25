import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
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
    String filtersJson =
        '{"filters":[{"name":"Fruta"},{"name":"Carne"},{"name":"Grão"},{"name":"Verdura"},{"name":"Doces"},{"name":"Massa"}]}';
    Map<String, dynamic> mapFilters = jsonDecode(filtersJson);
    List<dynamic> listFilters = mapFilters['filters'];
    AuthService auth = AuthService();
    String? _userDisplayName = 'Usuário';
    if (auth.user != null && auth.user!.displayName != null) {
      _userDisplayName = auth.user!.displayName;
    }
    String notificationsJson =
        '{"notifications":[{"description":"Refeições realizadas hoje","statistic":"2/2"},{"description":"Refeições realizadas ontem","statistic":"2/3"},{"description":"Refeições programadas para a amanhã","statistic":"0/1"},{"description":"Copos de água ingeridos","statistic":"2/5"},{"description":"Idas ao mercado","statistic":"5/5"}]}';
    Map<String, dynamic> mapNotifications = jsonDecode(notificationsJson);
    List<dynamic> listNotifications = mapNotifications['notifications'];
    Size _size = MediaQuery.of(context).size;
    double _widthPercentage = 0.90;
    double _heightPercentage = 0.17;

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
            child: Column(
      children: [
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 30, left: 30),
                child: new Text(
                  'Olá, $_username',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ))
          ],
        ),
        new Card(
          margin: const EdgeInsets.all(30),
          child: new SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(listFilters.length, (sequenceFilter) {
                return FlipCard(
                  speed: 1,
                  front: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Image.asset(SourceUtils.LOGO_SRC),
                            Text(
                              listFilters[sequenceFilter]['name'],
                              style: TextStyle(
                                  height: 4, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  back: Container(
                    child: Card(
                        color: Color.fromRGBO(173, 173, 173, 0),
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Image.asset(SourceUtils.LOGO_SRC),
                                Text(
                                  listFilters[sequenceFilter]['name'],
                                  style: TextStyle(
                                      height: 4, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ))),
                  ),
                );
              }),
            ),
          ),
          new Text(
            'Olá, $_userDisplayName',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey),
              margin: const EdgeInsets.all(10.0),
              height: _size.height * _heightPercentage,
              width: _size.width * _widthPercentage,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getFilterOption('Legumes'),
                    getFilterOption('Verduras'),
                    getFilterOption('Carnes')
                  ],
                ),
              ),
        ),
        Divider(
          height: 35,
          thickness: 2,
          indent: 30,
          endIndent: 30,
          color: Colors.grey,
        ),
        Row(children: [
          Padding(
              padding: EdgeInsets.only(top: 30, left: 30),
              child: new Text(
                'Objetivos',
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ))
        ]),
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
    )));
  }
}
