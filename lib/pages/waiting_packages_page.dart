import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kolayca_teslimat/models/package_model.dart';
import 'package:kolayca_teslimat/stores/package_store.dart';
import 'package:kolayca_teslimat/stores/root_store.dart';
import 'package:kolayca_teslimat/stores/theme_store.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class WaitingPackagesPage extends StatefulWidget {
  const WaitingPackagesPage({Key? key}) : super(key: key);

  @override
  State<WaitingPackagesPage> createState() => _WaitingPackagesPageState();
}

class _WaitingPackagesPageState extends State<WaitingPackagesPage> {
  int crossAxisCount = 1;

  late PackageStore packageStore;
  late ThemeStore themeStore;

  @override
  void initState() {
    super.initState();

    () async {
      await Future.delayed(Duration.zero);
      await packageStore.fetchPackages();
    }();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    RootStore rootStore = Provider.of<RootStore>(context);
    packageStore = rootStore.packageStore;
    themeStore = rootStore.themeStore;
  }

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
      child: RefreshIndicator(
        backgroundColor: themeStore.primaryColor,
        onRefresh: () async {
          await packageStore.fetchPackages();
        },
        child: Observer(builder: (context) {
          return packageStore.packages.isNotEmpty
              ? GridView.count(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: crossAxisCount > 1 ? 1 : 16 / 9,
                  padding: const EdgeInsets.all(20),
                  children: packageStore.packages
                      .map((package) => buildPackContainer(package))
                      .toList(),
                )
              : const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  Widget buildPackContainer(PackageModel package) {
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
            Text("Fiyat: ${package.price} ₺"),
            Text("Durum: ${package.status}")
          ],
        ),
      ),
      onTap: () {
        packageStore.choosePackage(package);
        Navigator.of(context).pushNamed(Routes.package);
      },
    );
  }
}
