import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kolayca_teslimat/stores/package_store.dart';
import 'package:kolayca_teslimat/stores/root_store.dart';
import 'package:kolayca_teslimat/stores/theme_store.dart';
import 'package:kolayca_teslimat/widgets/my_custom_drawer.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../models/package_model.dart';
import 'const.dart';

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
  Set<Polyline> polylines = {};

  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(37.214994, 28.363613), zoom: 14);

  int myCounter = 0;

  BitmapDescriptor defaultMarkerIcon = BitmapDescriptor.defaultMarker,
      waitingMarkerIcon = BitmapDescriptor.defaultMarker,
      onCarMarkerIcon = BitmapDescriptor.defaultMarker,
      completeMarkerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/bekleniyor.png")
        .then((icon) => setState(() {
              waitingMarkerIcon = icon;
            }));
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/aracta.png")
        .then((icon) => setState(() {
              onCarMarkerIcon = icon;
            }));
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/teslimedildi.png")
        .then((icon) => setState(() {
              completeMarkerIcon = icon;
            }));

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
                  title: package.id.toString(), snippet: package.status),
              icon: switchIcon(package.status)))
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.place),
        onPressed: () async {
          await showJustMyPackages();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: buildMap(),
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
        polylines: polylines,
      );

  Future showJustMyPackages() async {
    try {
      filterAractaPackages();
      List<double> myLocation = await updateCameraForMyLocation();
      await buildRoute(myLocation[0], myLocation[1]);
    } catch (e) {
      print("showJustMyPackages Error: $e");
    }
  }

  filterAractaPackages() {
    setState(() {
      markers = packageStore.packages
          .where((package) => package.status == "Araçta")
          .map((package) => Marker(
              markerId: MarkerId(package.id.toString()),
              position:
                  LatLng(package.position.latitude, package.position.longitude),
              infoWindow: InfoWindow(
                  title: package.id.toString(), snippet: package.status),
              icon: switchIcon(package.status)))
          .toSet();
    });
  }

  Future<List<double>> updateCameraForMyLocation() async {
    try {
      LocationData? locationData = await fetchMyLocation();

      setState(() {
        markers.add(Marker(
            markerId: const MarkerId("MyLocation"),
            position: LatLng(locationData!.latitude!, locationData.longitude!),
            infoWindow: const InfoWindow(title: "Konumum"),
            icon: defaultMarkerIcon));
      });

      await (await controller.future).animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(locationData!.latitude!, locationData.longitude!),
              zoom: 14)));

      return [locationData.latitude!, locationData.longitude!];
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future buildRoute(double latitude, double longitude) async {
    await packageStore.route(latitude, longitude);
    setState(() {
      polylines.clear();

      for (PackageRouteModel route in packageStore.routes) {
        int index = packageStore.routes.indexOf(route);

        polylines.add(Polyline(
            polylineId: PolylineId("PolyLine$index"),
            color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(.5),
            points: decode(route.polyline.encodedPolyline),
            zIndex: index + 1,
            width: index + 5));
      }
    });
  }

  BitmapDescriptor switchIcon(String packageStatus) {
    BitmapDescriptor icon = defaultMarkerIcon;

    switch (packageStatus) {
      case "Bekleniyor":
        icon = waitingMarkerIcon;
        break;
      case "Araçta":
        icon = onCarMarkerIcon;
        break;
      case "Teslim Edildi":
        icon = completeMarkerIcon;
        break;
    }

    return icon;
  }

  List<LatLng> decode(String encodedPolyline) {
    List lList = [];
    int index = 0, c = 0;
    List<LatLng> positions = [];

    do {
      int shift = 0, result = 0;

      do {
        c = encodedPolyline.codeUnits[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);

      if (result & 1 == 1) {
        result = ~result;
      }
      lList.add((result >> 1) * .00001);
    } while (index < encodedPolyline.length);

    for (int i = 2; i < lList.length; i++) {
      lList[i] += lList[i - 2];
    }

    for (int i = 0; i < lList.length; i += 2) {
      positions.add(LatLng(lList[i], lList[i + 1]));
    }
    return positions;
  }
}
