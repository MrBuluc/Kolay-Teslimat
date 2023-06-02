import 'package:flutter/material.dart';
import 'package:kolayca_teslimat/models/package_model.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({Key? key}) : super(key: key);

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  Package? package;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        package = ModalRoute.of(context)!.settings.arguments as Package;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paket Detayı"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Paket ID: ${package?.id}",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Text(
                "Durum: ${package?.status}",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Text("Tipi: ${package?.typeName}"),
              Text("Fiyatı: ${package?.price} ₺"),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(),
              ),
              Text("Gönderen: ${package?.sender}"),
              Text("Gönderen Adresi: ${package?.senderAddress}"),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(),
              ),
              Text("Alıcı: ${package?.receiver}"),
              Text("Alıcı Adresi: ${package?.receiverAddress}")
            ],
          ),
        ),
      );
}
