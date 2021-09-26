import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/recipe/repositories/RecipePage.dart';
import 'package:myownmenu/src/notification/repositories/NotificationPage.dart';
import 'package:myownmenu/src/welcome/repositories/WelcomePage.dart';
import 'package:myownmenu/src/configuration/repositories/ConfigurationPage.dart';
import 'package:myownmenu/src/dispense/repositories/DispensePage.dart';
import 'package:myownmenu/src/ingredient/repositories/IngredientPage.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/profile/repositories/ProfilePage.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _selectedIndex = 0;
  dynamic _selectedDestination;
  final List? _options = [
    WelcomePage(),
    RecipePage(),
    NotificationPage(),
    Dispense(),
    Ingredient(),
    Configuration(),
    Profile(),
    Login()
  ];
  @override
  Widget build(BuildContext context) {
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
                      onTap: () => {sideBarDestination(3)},
                    ),
                    ListTile(
                      leading: Icon(Icons.local_cafe),
                      title: Text('Ingredientes'),
                      selected: _selectedDestination == 1,
                      onTap: () => {sideBarDestination(4)},
                    ),
                    ListTile(
                      leading: Icon(Icons.build),
                      title: Text('Configurações'),
                      selected: _selectedDestination == 2,
                      onTap: () => {sideBarDestination(5)},
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('Perfil'),
                      selected: _selectedDestination == 3,
                      onTap: () => {sideBarDestination(6)},
                    ),
                    ListTile(
                      leading: Icon(Icons.input),
                      title: Text('Sair'),
                      selected: _selectedDestination == 4,
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        )
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
      body: _options![_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Receitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificações',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _selectedIndex = index;
      _selectedDestination = null;
    });
  }

  void sideBarDestination(int selected) {
    setState(() {
      _selectedDestination = selected - 3;
      _selectedIndex = selected;
    });
    Navigator.pop(context);
  }
}
