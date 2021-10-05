import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/utils/SourceUtils.dart';
import 'Dart:convert';

class Ingredient extends StatelessWidget {
  const Ingredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      debugShowCheckedModeBanner: false,
      home: IngredientPage(),
    );
  }
}

class IngredientPage extends StatefulWidget {
  const IngredientPage({Key? key}) : super(key: key);

  @override
  _IngredientPageState createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  Widget build(BuildContext context) {
    String ingredientsJson =
        '{"ingredients":[{"selected":true},{"selected":false},{"selected":true},{"selected":false},{"selected":true},{"selected":false}]}';
    Map<String, dynamic> mapIngredients = jsonDecode(ingredientsJson);
    List<dynamic> list = mapIngredients['ingredients'];

    bool _getVisibility(index) {
      dynamic item = list[index];
      return item['selected'];
    }

    void _toggle(index) {
      dynamic item = list[index];
      print("1 -item: " + item.toString());
      setState(() {
        Map<String, dynamic> map = {'selected': !item['selected']};
        item['selected'] = map;
        print("2 - item: " + item.toString());
      });
      print("3 - item: " + item.toString());
    }

    Widget cardIngredient(index) {
      return Visibility(
          visible: !_getVisibility(index),
          child: Card(
              margin: const EdgeInsets.only(bottom: 30),
              child: InkWell(
                splashColor: Colors.grey.withAlpha(50),
                onTap: () {
                  print('Card Ingredient tapped - ' + index.toString());
                  _toggle(index);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        "Ingrediente teste",
                        style: TextStyle(
                          height: 4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      SourceUtils.INGREDIENTE_SRC,
                    ),
                  ],
                ),
              )));
    }

    Widget cardSelect(index) {
      return Visibility(
          visible: _getVisibility(index),
          child: Card(
              child: InkWell(
            splashColor: Colors.grey.withAlpha(50),
            onTap: () {
              print('Card Selectd tapped - ' + index.toString());
              _toggle(index);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    color: Color.fromRGBO(156, 156, 156, 100),
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: TextButton(
                          child: const Icon(
                            Icons.check_box,
                            color: Color.fromRGBO(0, 0, 0, 100),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ))),
                Container(
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Ingrediente teste",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
              ],
            ),
          )));
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        new Container(
          child: Column(
            children: [
              new Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 30),
                      child: Text(
                        'Ingredientes',
                        style: TextStyle(color: Colors.black, fontSize: 24.0),
                      ))
                ],
              ),
              new Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 30, left: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'O que deseja?',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.filter_list,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        new Container(
          margin: const EdgeInsets.all(30),
          child: new SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(list.length, (index) {
                return new Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Image.asset(SourceUtils.LOGO_SRC),
                          Text(
                            "Teste",
                            style: TextStyle(
                                height: 4, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ));
              }),
            ),
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: new Column(
            children: List.generate(list.length, (index) {
              return Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    cardIngredient(index),
                    cardSelect(index),
                  ],
                ),
              );
            }),
          ),
        )
      ],
    )));
  }
}
