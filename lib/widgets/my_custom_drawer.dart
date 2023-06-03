import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kolayca_teslimat/routes.dart';
import 'package:kolayca_teslimat/stores/auth_store.dart';
import 'package:kolayca_teslimat/stores/root_store.dart';
import 'package:kolayca_teslimat/stores/theme_store.dart';
import 'package:provider/provider.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({Key? key}) : super(key: key);

  @override
  State<MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  late RootStore rootStore;
  late ThemeStore themeStore;
  late AuthStore authStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    rootStore = Provider.of<RootStore>(context);
    themeStore = rootStore.themeStore;
    authStore = rootStore.authStore;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: themeStore.primaryColor),
              child: Text("Hoşgeldin ${authStore.user?.firstName ?? " "}"),
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
                authStore.logout();
                /*Navigator.pop(context);
                Navigator.of(context).pushReplacementNamed(Routes.login);*/
              },
            )
          ],
        ),
      );
    });
  }
}
