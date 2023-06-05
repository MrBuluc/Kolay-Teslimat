import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kolayca_teslimat/models/package_model.dart';
import 'package:kolayca_teslimat/stores/auth_store.dart';
import 'package:kolayca_teslimat/stores/root_store.dart';
import 'package:kolayca_teslimat/widgets/my_card.dart';
import 'package:provider/provider.dart';

import '../stores/package_store.dart';
import '../widgets/take_photo_page.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({Key? key}) : super(key: key);

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  late PackageStore packageStore;
  late AuthStore authStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    RootStore rootStore = Provider.of<RootStore>(context);
    packageStore = rootStore.packageStore;
    authStore = rootStore.authStore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paket Detayı"),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Observer(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildBasicInfo(),
                buildReceiverInfo(),
                buildSenderInfo(),
                buildMoveToCar(),
                buildComplete(),
              ],
            );
          }),
        ),
      );

  Widget buildBasicInfo() => MyCard(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              packageStore.package?.status ?? "",
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "#${packageStore.package?.id}",
              style: const TextStyle(fontSize: 24),
            )
          ],
        ),
        Text(
          packageStore.package?.typeName ?? "",
          style: const TextStyle(fontSize: 16),
        ),
        Text("₺${packageStore.package?.price}")
      ]);

  Widget buildPersonInfo(bool isReceiver, PackagePersonModel? person) =>
      MyCard(children: [
        Text(
          isReceiver ? "Alıcı" : "Gönderici",
          style: const TextStyle(fontSize: 24),
        ),
        Text(
          person!.fullName,
          style: const TextStyle(fontSize: 24),
        ),
        Text(
          person.phoneNumber,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          "${person.address}, "
          "${person.district}, "
          "${person.city}",
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          person.postalCode,
          style: const TextStyle(fontSize: 16),
        )
      ]);

  Widget buildReceiverInfo() =>
      buildPersonInfo(true, packageStore.package?.receiver);

  Widget buildSenderInfo() =>
      buildPersonInfo(false, packageStore.package?.sender);

  Widget buildMoveToCar() => packageStore.package?.status == "Bekleniyor" &&
          (packageStore.package?.responsibleUserId == null ||
              packageStore.package?.responsibleUserId == authStore.user?.id)
      ? ElevatedButton(
          child: const Text("Araca Taşı"),
          onPressed: () async {
            await packageStore.moveToCar();
          },
        )
      : const SizedBox.shrink();

  Widget buildComplete() => packageStore.package?.status == "Araçta" &&
          packageStore.package?.responsibleUserId == authStore.user?.id
      ? ElevatedButton(
          child: const Text("Teslim Et"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const TakePhotoPage()));
          },
        )
      : const SizedBox.shrink();
}
