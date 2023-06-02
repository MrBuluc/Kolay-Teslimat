import 'package:flutter/material.dart';
import 'package:kolayca_teslimat/routes.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({Key? key}) : super(key: key);

  @override
  State<MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.brown),
            child: Text("Kolayca Teslimat"),
          ),
          ListTile(
            title: const Text("Rota Haritası"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            title: const Text("Bekleyen Paketler"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.waitingPackages);
            },
          ),
          ListTile(
            title: const Text("Çıkış Yap"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(Routes.login);
            },
          )
        ],
      ),
    );
  }
}
