import 'package:flutter/material.dart';
import 'package:kolayca_teslimat/stores/root_store.dart';
import 'package:kolayca_teslimat/stores/theme_store.dart';
import 'package:kolayca_teslimat/widgets/my_custom_drawer.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int myCounter = 0;

  late RootStore rootStore;
  late ThemeStore themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    rootStore = Provider.of<RootStore>(context);
    themeStore = rootStore.themeStore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kolayca Teslimat"),
      ),
      drawer: const MyCustomDrawer(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Hero(
              tag: "logo",
              child: Icon(
                Icons.local_shipping,
                size: 50,
                color: Colors.brown,
              )),
          Text("My Counter: $myCounter"),
          ElevatedButton(
            child: const Text("Arttır"),
            onPressed: () {
              themeStore.changePrimaryColor(Colors.black);
            },
          ),
          const Divider(),
          Image.asset("assets/images/package-1.png"),
          Image.asset("assets/images/package-2.png")
        ],
      ),
    );
  }
}
