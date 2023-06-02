import 'package:flutter/material.dart';
import 'package:kolayca_teslimat/models/package_model.dart';

import '../routes.dart';

class WaitingPackagesPage extends StatefulWidget {
  const WaitingPackagesPage({Key? key}) : super(key: key);

  @override
  State<WaitingPackagesPage> createState() => _WaitingPackagesPageState();
}

class _WaitingPackagesPageState extends State<WaitingPackagesPage> {
  List<Package> packages = [
    Package(
        id: "1",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
    Package(
        id: "2",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
    Package(
        id: "3",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
    Package(
        id: "4",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
    Package(
        id: "5",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
    Package(
        id: "6",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
    Package(
        id: "7",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
    Package(
        id: "8",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
    Package(
        id: "9",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
    Package(
        id: "10",
        typeName: "Standart Gönderim",
        status: "Depoda",
        price: 15.5,
        receiver: "Gökhan Karaca +905123456789",
        sender: "Amazon"),
  ];

  int crossAxisCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bekleyen Paketler"),
        actions: [
          IconButton(
            icon: Icon(crossAxisCount == 1 ? Icons.grid_view : Icons.view_list),
            onPressed: () {
              setState(() {
                crossAxisCount = crossAxisCount == 1 ? 2 : 1;
              });
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.near_me),
        onPressed: () {},
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: crossAxisCount > 1 ? 1 : 16 / 9,
        padding: const EdgeInsets.all(20),
        children: packages.map((package) => buildPack(package)).toList(),
      ),
    );
  }

  Widget buildPack(Package package) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Paket ID: ${package.id}"),
            Text("Tip: ${package.typeName}"),
            Text("Fiyat: ${package.price} ₺")
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(Routes.package, arguments: package);
      },
    );
  }
}
