import 'package:flutter/material.dart';
import 'package:kolayca_teslimat/pages/splash_page.dart';
import 'package:kolayca_teslimat/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const SplashPage(),
      onGenerateRoute: Routes().onGenerateRoute,
    );
  }
}
