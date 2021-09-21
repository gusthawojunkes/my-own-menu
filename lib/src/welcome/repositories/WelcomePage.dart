import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Container(
              child: Image.asset(
                './lib/assets/BackgroundTopMenu.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
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
    /*return Scaffold(
      body: Column(children: [
        new Container(
          child: Image.asset(
            './lib/assets/BackgroundTopMenu.png',
            fit: BoxFit.fill,
          ),
        ),
        Row(
          children: [
            Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Header',
                      style: textTheme.headline6,
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Item 1'),
                    selected: _selectedDestination == 0,
                    onTap: () => selectDestination(0),
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Item 2'),
                    selected: _selectedDestination == 1,
                    onTap: () => selectDestination(1),
                  ),
                  ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Item 3'),
                    selected: _selectedDestination == 2,
                    onTap: () => selectDestination(2),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Label',
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.bookmark),
                    title: Text('Item A'),
                    selected: _selectedDestination == 3,
                    onTap: () => selectDestination(3),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
            ),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  padding: EdgeInsets.all(20),
                  childAspectRatio: 3 / 2,
                  children: [
                    Image.asset('./lib/assets/LogoTemporaria.png'),
                    Image.asset('./lib/assets/LogoTemporaria.png'),
                    Image.asset('./lib/assets/LogoTemporaria.png'),
                    Image.asset('./lib/assets/LogoTemporaria.png'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );*/
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
