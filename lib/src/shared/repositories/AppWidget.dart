import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myownmenu/src/welcome/repositories/WelcomePage.dart';

class MyOnwMenuApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Own Menu',
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Error! ${snapshot.error.toString()}');
              return Text("You have an error!");
            } else if (snapshot.hasData) {
              return Welcome();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
        //Welcome(),
        );
  }
}
