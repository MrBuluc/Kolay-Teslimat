import 'package:flutter/material.dart';

class WaitingPackagesPage extends StatefulWidget {
  const WaitingPackagesPage({Key? key}) : super(key: key);

  @override
  State<WaitingPackagesPage> createState() => _WaitingPackagesPageState();
}

class _WaitingPackagesPageState extends State<WaitingPackagesPage> {
  List<int> packages = List.generate(15, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bekleyen Paketler"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.near_me),
        onPressed: () {},
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: packages.map((packageNo) => buildPack(packageNo)).toList(),
        ),
      ),
    );
  }

  Widget buildPack(int packageNo) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Standart Paket",
                style: TextStyle(fontSize: 18),
              ),
              Text("15 ₺")
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Gönderici",
              ),
              Text("Alıcı")
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ahmet",
              ),
              Text("Ayşe")
            ],
          )
        ],
      ),
    );
  }
}
