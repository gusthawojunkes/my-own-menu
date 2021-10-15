import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/service/auth/AuthService.dart';
import 'package:provider/provider.dart';
import 'src/shared/repositories/AppWidget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService())
      ],
      child: MyOnwMenuApp()
    )
  );
}
