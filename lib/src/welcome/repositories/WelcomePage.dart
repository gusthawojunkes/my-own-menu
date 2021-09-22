import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/configuration/repositories/ConfigurationPage.dart';
import 'package:myownmenu/src/dispense/repositories/DispensePage.dart';
import 'package:myownmenu/src/ingredient/repositories/IngredientPage.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/profile/repositories/ProfilePage.dart';

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
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    //final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white12,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.only(top: 90),
                child: TextButton(
                  child: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            new Padding(
                padding: const EdgeInsets.only(top: 45, left: 20),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.featured_play_list),
                      title: Text('Dispensa'),
                      selected: _selectedDestination == 0,
                      onTap: () => selectDestination(0),
                    ),
                    ListTile(
                      leading: Icon(Icons.local_cafe),
                      title: Text('Ingredientes'),
                      selected: _selectedDestination == 1,
                      onTap: () => selectDestination(1),
                    ),
                    ListTile(
                      leading: Icon(Icons.build),
                      title: Text('Configurações'),
                      selected: _selectedDestination == 2,
                      onTap: () => selectDestination(2),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('Perfil'),
                      selected: _selectedDestination == 3,
                      onTap: () => selectDestination(3),
                    ),
                    ListTile(
                      leading: Icon(Icons.input),
                      title: Text('Sair'),
                      selected: _selectedDestination == 4,
                      onTap: () => selectDestination(4),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void selectDestination(int index) {
    final List _options = [
      Dispense(),
      Ingredient(),
      Configuration(),
      Profile(),
      Login()
    ];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _options[index]),
    );
  }
}
