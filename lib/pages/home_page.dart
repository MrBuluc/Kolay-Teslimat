import 'package:flutter/material.dart';
import 'package:kolayca_teslimat/widgets/my_custom_drawer.dart';

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
        title: const Text("Kolayca Teslimat"),
      ),
      drawer: const MyCustomDrawer(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Text("My Counter: $myCounter"),
        ElevatedButton(
          onPressed: () {
            setState(() {
              myCounter += 1;
            });
          },
          child: const Text("Arttır"),
        )
      ],
    );
  }
}
