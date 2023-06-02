import 'package:flutter/material.dart';
import 'package:kolayca_teslimat/pages/home_page.dart';
import 'package:kolayca_teslimat/pages/login_page.dart';
import 'package:kolayca_teslimat/pages/package_page.dart';
import 'package:kolayca_teslimat/pages/splash_page.dart';
import 'package:kolayca_teslimat/pages/waiting_packages_page.dart';

class Routes {
  Routes();

  static const String splash = "/splash";
  static const String login = "/login";
  static const String home = "/home";
  static const String waitingPackages = "/waitingPackages";
  static const String package = "/package";

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
            builder: (context) => const SplashPage(), settings: settings);
      case Routes.login:
        return MaterialPageRoute(
            builder: (context) => const LoginPage(), settings: settings);
      case Routes.home:
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(), settings: settings);
      case Routes.waitingPackages:
        return MaterialPageRoute(
            builder: (context) => const WaitingPackagesPage(),
            settings: settings);
      case Routes.package:
        return MaterialPageRoute(
            builder: (context) => const PackagePage(), settings: settings);
    }

    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(
                child: Text("Page Not Found"),
              ),
            ));
  }
}
