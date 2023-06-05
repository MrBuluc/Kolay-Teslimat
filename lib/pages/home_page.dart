import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kolayca_teslimat/stores/package_store.dart';
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
  late PackageStore packageStore;
  late ThemeStore themeStore;

  Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  Set<Marker> markers = {};

  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(37.214994, 28.363613), zoom: 14);

  int myCounter = 0;

  @override
  void initState() {
    super.initState();

    () async {
      await Future.delayed(Duration.zero);

      await packageStore.fetchPackages();

      bindMarkers();
    }();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    RootStore rootStore = Provider.of<RootStore>(context);
    packageStore = rootStore.packageStore;
    themeStore = rootStore.themeStore;
  }

  bindMarkers() {
    setState(() {
      markers = packageStore.packages
          .map((package) => Marker(
              markerId: MarkerId(package.id.toString()),
              position:
                  LatLng(package.position.latitude, package.position.longitude),
              infoWindow: InfoWindow(
                  title: package.id.toString(),
                  snippet: package.receiver.address)))
          .toSet();
    });
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
          Hero(
              tag: "logo",
              child: Observer(builder: (context) {
                return Icon(
                  Icons.local_shipping,
                  size: 50,
                  color: themeStore.primaryColor,
                );
              })),
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

  Widget buildMap() => GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        markers: markers,
        onMapCreated: (GoogleMapController mapController) {
          controller.complete(mapController);
        },
      );
}
