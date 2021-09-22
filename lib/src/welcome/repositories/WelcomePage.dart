import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    String _username = 'Usuário';
    Size _size = MediaQuery.of(context).size;
    double _widthPercentage = 0.90;
    double _heightPercentage = 0.17;
    return Scaffold(
      body: Column(
        children: [
          Container(
            child:
                Image.asset(SourceUtils.BACKGROUND_TOP_SRC, fit: BoxFit.fill),
          ),
          new Text(
            'Olá, $_username',
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
          ),
          Divider(
            height: 35,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          Spacer()
        ],
      ),
    );
  }

  goToFilterOption(String _caption) {
    print(_caption);
    //Go to recipes page based on selected
  }

  Expanded getFilterOption(String _caption) {
    return Expanded(
      child: Container(
        child: ElevatedButton(
          onPressed: () => { 
            goToFilterOption(_caption) 
          },
          child: Text(_caption),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(30),
            primary: Colors.green
          ),
        ),
      ),
    );
  }
}
