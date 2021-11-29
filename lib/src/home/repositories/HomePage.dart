import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/src/registerGoal/repositories/RegisterGoalPage.dart';
import 'package:myownmenu/src/registerIngredient/repositories/RegisterIngredientPage.dart';
import 'package:myownmenu/src/registerRecipe/repositories/RegisterRecipePage.dart';
import 'package:myownmenu/src/registerType/repositories/RegisterTypePage.dart';
import 'package:myownmenu/utils/ColorsUtils.dart';
import 'package:myownmenu/src/recipe/repositories/RecipePage.dart';
import 'package:myownmenu/src/notification/repositories/NotificationPage.dart';
import 'package:myownmenu/src/shared/repositories/AppModule.dart';
import 'package:myownmenu/src/welcome/repositories/WelcomePage.dart';
import 'package:myownmenu/src/configuration/repositories/ConfigurationPage.dart';
import 'package:myownmenu/src/dispense/repositories/DispensePage.dart';
import 'package:myownmenu/src/ingredient/repositories/IngredientPage.dart';
import 'package:myownmenu/src/login/repositories/LoginPage.dart';
import 'package:myownmenu/src/profile/repositories/ProfilePage.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

class Home extends StatelessWidget {
  final int? page;

  const Home({Key? key, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      home: HomePage(
        page: page,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final int? page;

  const HomePage({Key? key, this.page}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentIndex = 0;
  dynamic _selectedDestination;
  final List? _options = [
    WelcomePage(),
    RecipePage(),
    NotificationPage(),
    Dispense(),
    Ingredient(),
    Configuration(),
    Profile(),
    RegisterRecipe(),
    RegisterIngredient(),
    RegisterGoal(),
    RegisterType()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white12,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(SourceUtils.BACK_SIDE_MENU_SRC),
                        fit: BoxFit.fill)),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    new Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: TextButton(
                          child: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ))
                  ],
                )),
            new Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.featured_play_list,
                          color: ColorsUtils.darkBlue),
                      title: Text('Dispensa',
                          style: TextStyle(color: ColorsUtils.darkBlue)),
                      selected: _selectedDestination == 0,
                      onTap: () => {sideBarDestination(3)},
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.local_cafe, color: ColorsUtils.darkBlue),
                      title: Text('Ingredientes',
                          style: TextStyle(color: ColorsUtils.darkBlue)),
                      selected: (_selectedDestination == 1),
                      onTap: () => {sideBarDestination(4)},
                    ),
                    ListTile(
                      leading: Icon(Icons.build, color: ColorsUtils.darkBlue),
                      title: Text('Configurações',
                          style: TextStyle(color: ColorsUtils.darkBlue)),
                      selected: _selectedDestination == 2,
                      onTap: () => {sideBarDestination(5)},
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle,
                          color: ColorsUtils.darkBlue),
                      title: Text('Perfil',
                          style: TextStyle(color: ColorsUtils.darkBlue)),
                      selected: _selectedDestination == 3,
                      onTap: () => {sideBarDestination(6)},
                    ),
                    ListTile(
                      title: Divider(),
                    ),
                    ListTile(
                      leading: Icon(Icons.create, color: ColorsUtils.darkBlue),
                      title: Text('Receita',
                          style: TextStyle(color: ColorsUtils.darkBlue)),
                      selected: _selectedDestination == 4,
                      onTap: () => {sideBarDestination(7)},
                    ),
                    ListTile(
                      leading: Icon(Icons.create_outlined,
                          color: ColorsUtils.darkBlue),
                      title: Text('Ingrediente',
                          style: TextStyle(color: ColorsUtils.darkBlue)),
                      selected: _selectedDestination == 5,
                      onTap: () => {sideBarDestination(8)},
                    ),
                    ListTile(
                      leading: Icon(Icons.create_rounded,
                          color: ColorsUtils.darkBlue),
                      title: Text('Objetivo',
                          style: TextStyle(color: ColorsUtils.darkBlue)),
                      selected: _selectedDestination == 6,
                      onTap: () => {
                        sideBarDestination(9),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.create_outlined,
                          color: ColorsUtils.darkBlue),
                      title: Text('Tipo',
                          style: TextStyle(color: ColorsUtils.darkBlue)),
                      selected: _selectedDestination == 7,
                      onTap: () => {sideBarDestination(10)},
                    ),
                    ListTile(
                      title: Divider(),
                    ),
                    new Container(
                        padding: EdgeInsets.only(bottom: 30),
                        child: ListTile(
                          leading:
                              Icon(Icons.input, color: ColorsUtils.darkBlue),
                          title: Text('Sair',
                              style: TextStyle(color: ColorsUtils.darkBlue)),
                          selected: _selectedDestination == 5,
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            )
                          },
                        ))
                  ],
                ))
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
