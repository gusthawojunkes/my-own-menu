import 'package:flutter/material.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:myownmenu/src/home/repositories/HomePage.dart';
import 'package:myownmenu/src/index/repositories/IndexPage.dart';
import 'package:provider/provider.dart';

class MyOnwMenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoading) return loading();
    else if (auth.user == null)
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Own Menu',
        home: Index()
      );
    else
      return Home();
  }

  loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
