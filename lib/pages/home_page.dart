import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int myCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kolayca Teslimat"),
      ),
      drawer: buildDrawer(),
      body: buildBody(),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Kolayca Teslimat"),
            decoration: BoxDecoration(color: Colors.brown),
          ),
          ListTile(
            title: Text("Rota Haritası"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Bekleyen Paketler"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Çıkış Yap"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Container(
      child: Column(
        children: [
          Text("My Counter: ${myCounter}"),
          ElevatedButton(
            onPressed: () {
              setState(() {
                myCounter += 1;
              });
            },
            child: Text("Arttır"),
          )
        ],
      ),
    );
  }
}
