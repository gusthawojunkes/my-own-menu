import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flip_card/flip_card.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';
import 'package:myownmenu/utils/SourceUtils.dart';
import 'package:myownmenu/components/Filter.dart';
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
    HashSet<dynamic> listFilters = _getFilters();
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
                      margin: const EdgeInsets.all(30),
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(listFilters.length,
                              (sequenceFilter) {
                            return FlipCard(
                              speed: 1,
                              front: Container(
                                child: filter(listFilters, sequenceFilter,
                                    Colors.white, ColorsUtils.darkBlue),
                              ),
                              back: Container(
                                child: filter(listFilters, sequenceFilter,
                                    ColorsUtils.darkBlue, Colors.white),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Divider(
                      height: 35,
                      thickness: 2,
                      indent: 30,
                      endIndent: 30,
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
                ))));
  }
}

HashSet<String> _getFilters() {
  var listFilter = new HashSet<String>();
  List<dynamic> listIngredients = _getIngredients();

  for (var ingredient in listIngredients) listFilter.add(ingredient['type']);

  return listFilter;
}

List<dynamic> _getIngredients() {
  String ingredientsJson =
      '{"ingredients":[{"name":"Abacate","type":"Fruta"},{"name":"Alcatra","type":"Carne"},{"name":"Arroz","type":"Grão"},{"name":"Feijão","type":"Grão"},{"name":"Maça","type":"Fruta"},{"name":"Milho","type":"Grão"}]}';

  Map<String, dynamic> mapIngredients = jsonDecode(ingredientsJson);
  List<dynamic> listIngredients = mapIngredients['ingredients'];
  return listIngredients;
}
