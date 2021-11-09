import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:myownmenu/src/changeName/repositories/ChangeNamePage.dart';
import 'package:myownmenu/src/changePassword/repositories/ChangePasswordPage.dart';
import 'package:myownmenu/src/welcome/repositories/WelcomePage.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = "{{username}}";
  String _email = "username@email.com.br";
  dynamic imageUser = getImage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new SingleChildScrollView(
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
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  new Column(children: [
                    new Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: new InkWell(
                          child: Image.asset(
                            imageUser,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        )),
                    new Text(_username,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    new Text(_email, style: TextStyle(fontSize: 14)),
                  ]),
                  new Column(
                    children: [
                      new Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: new Container(
                          height: 80,
                          width: double.infinity,
                          child: new Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangeName()),
                                );
                              },
                              child: new Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.people),
                                      new Text("Alterar Nome")
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: new Container(
                          height: 80,
                          width: double.infinity,
                          child: new Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePassword()),
                                );
                              },
                              child: new Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.vpn_key),
                                      new Text("Alterar Senha")
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.only(top: 30),
                        child: InkWell(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.input), Text('Voltar')],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Welcome()),
                            );
                          },
                        ),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    ));
  }
}

getImage() {
  dynamic imageUserDefault = SourceUtils.NO_USER_SRC;
  dynamic imageUser;

  if (imageUser == null) {
    imageUser = imageUserDefault;
  }

  return imageUser;
}
