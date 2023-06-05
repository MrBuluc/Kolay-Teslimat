import 'package:collection/collection.dart';
import 'package:kolayca_teslimat/injector.dart';
import 'package:kolayca_teslimat/models/package_model.dart';
import 'package:kolayca_teslimat/network/package_service.dart';
import 'package:mobx/mobx.dart';

part 'package_store.g.dart';

class PackageStore = _PackageStore with _$PackageStore;

abstract class _PackageStore with Store {
  final PackageService packageService = serviceLocator.get<PackageService>();

  @observable
  List<PackageModel> packages = ObservableList.of([]);

  @observable
  int? chosenPackageId;

  @computed
  PackageModel? get package =>
      packages.firstWhereOrNull((element) => element.id == chosenPackageId);

  @action
  Future fetchPackages() async {
    try {
      List<PackageModel> fetchedPackages = await packageService.getPackages();
      packages.clear();
      packages.addAll(fetchedPackages);
    } catch (e) {
      throw Exception("Failed to fetch packages");
    }
  }

  @action
  choosePackage(PackageModel packageModel) {
    chosenPackageId = packageModel.id;
  }

  @action
  Future moveToCar() async {
    packages[packages.indexOf(package!)] =
        await packageService.moveToCar(package!.id);
  }
}
