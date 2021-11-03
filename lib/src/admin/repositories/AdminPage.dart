import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/registerIngredient/repositories/RegisterIngredientPage.dart';
import 'package:myownmenu/src/registerRecipe/repositories/RegisterRecipePage.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin',
      debugShowCheckedModeBanner: false,
      home: AdminPage(),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SingleChildScrollView(
          child: new Container(
        child: new Stack(
          children: [
            new Container(
              width: double.infinity,
              child: Image.asset(
                SourceUtils.BACKGROUND_TOP_SRC,
                fit: BoxFit.fill,
              ),
            ),
            new Padding(
                padding: EdgeInsets.only(left: 30, bottom: 30, right: 30),
                child: Column(
                  children: [
                    new Row(
                      children: [
                        new Text(
                          'Admin',
                          style: new TextStyle(
                              color: Colors.black, fontSize: 24.0),
                        )
                      ],
                    ),
                    new Column(
                      children: [
                        new Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: new Container(
                            height: 110,
                            width: double.infinity,
                            child: new Card(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterRecipe()),
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
                        ),
                        new Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: new Container(
                            height: 110,
                            width: double.infinity,
                            child: new Card(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterIngredient()),
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
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
