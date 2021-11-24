import 'dart:collection';
import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';
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
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<dynamic> listNotifications = _getGoals();
  var cardKeys = Map<int, GlobalKey<FlipCardState>>();
  var selected = new HashSet<dynamic>();

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    String? _userDisplayName = 'Usuário';
    if (auth.user != null && auth.user!.displayName != null) {
      _userDisplayName = auth.user!.displayName;
    }

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

    Widget notificationSelected(int sequenceNotification) {
      return Container(
        width: 150,
        height: 170,
        child: Card(
            color: ColorsUtils.darkBlue,
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
                          style: const TextStyle(
                              fontSize: 17, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 5, right: 15, left: 15, bottom: 15),
                        child: Text(
                          listNotifications[sequenceNotification]
                              ['description'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 17),
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
                        padding: EdgeInsets.only(
                            top: 70, bottom: 60, left: 30, right: 30),
                        child: new Column(
                          children: [
                            Text(
                              "Seja Bem-Vindo!",
                              style: TextStyle(fontSize: 32),
                            )
                          ],
                        )),
                    Divider(
                      height: 35,
                      thickness: 2,
                      indent: 30,
                      endIndent: 30,
                    ),
                    new Container(
                        padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new Text(
                                'Objetivos',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18),
                              ),
                              new Row(
                                children: [
                                  new Visibility(
                                      visible: selected.isNotEmpty,
                                      child: new Container(
                                        padding: EdgeInsets.only(right: 10),
                                        child: new TextButton(
                                            onPressed: () {
                                              flipSelectedCards(
                                                  listNotifications,
                                                  selected,
                                                  cardKeys);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Objetivos retirados de seleção!')),
                                              );
                                            },
                                            child: Icon(Icons.block)),
                                      )),
                                  new Visibility(
                                      visible: selected.isNotEmpty,
                                      child: new ElevatedButton(
                                          onPressed: () {
                                            List<dynamic> selectedCards = [];
                                            for (var sequenceNotification
                                                in selected) {
                                              selectedCards
                                                  .add(sequenceNotification);
                                            }
                                            setState(() {
                                              flipSelectedCards(
                                                  listNotifications,
                                                  selected,
                                                  cardKeys);
                                              for (var item in selectedCards) {
                                                listNotifications.remove(item);
                                              }
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Objetivos selecionados foram excluidos!')),
                                            );
                                          },
                                          child: Icon(Icons.clear)))
                                ],
                              )
                            ])),
                    new Container(
                      margin: const EdgeInsets.only(right: 30, left: 30),
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(listNotifications.length,
                              (sequenceNotification) {
                            cardKeys.putIfAbsent(sequenceNotification,
                                () => GlobalKey<FlipCardState>());
                            GlobalKey<FlipCardState>? thisCard =
                                cardKeys[sequenceNotification];
                            return FlipCard(
                                key: thisCard,
                                onFlip: () {
                                  setState(() {
                                    selected.contains(listNotifications
                                            .elementAt(sequenceNotification))
                                        ? selected.remove(listNotifications
                                            .elementAt(sequenceNotification))
                                        : selected.add(listNotifications
                                            .elementAt(sequenceNotification));
                                  });
                                },
                                front: new Container(
                                  child: notification(sequenceNotification),
                                ),
                                back: new Container(
                                    child: notificationSelected(
                                        sequenceNotification)));
                          }),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}

List<dynamic> _getGoals() {
  String notificationsJson =
      '{"notifications":[{"description":"Refeições realizadas hoje","statistic":"2/2"},{"description":"Refeições realizadas ontem","statistic":"2/3"},{"description":"Refeições programadas para a amanhã","statistic":"0/1"},{"description":"Copos de água ingeridos","statistic":"2/5"},{"description":"Idas ao mercado","statistic":"5/5"}]}';
  Map<String, dynamic> mapNotifications = jsonDecode(notificationsJson);
  List<dynamic> listNotifications = mapNotifications['notifications'];
  return listNotifications;
}

void flipSelectedCards(listNotifications, selected, cardKeys) {
  List<dynamic> cardList = [];
  selected.forEach((cardSelected) {
    cardList.add(cardSelected);
  });

  for (var card in cardList) {
    cardKeys[listNotifications.indexOf(card)]!.currentState!.toggleCard();
  }
}
