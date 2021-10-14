import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:myownmenu/src/home/repositories/HomePage.dart';
import 'package:myownmenu/src/index/repositories/IndexPage.dart';
import 'package:provider/provider.dart';

class MyOnwMenuApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoading) return loading();
    else if (auth.user == null) return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Own Menu',
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error! ${snapshot.error.toString()}');
            return Text("You have an error!");
          } else if (snapshot.hasData) {
            return Index();
          } else {
            return loading();
          }
        },
      )
    );
    else return Home();
  }

  loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
