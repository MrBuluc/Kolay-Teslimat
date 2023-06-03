import 'package:kolayca_teslimat/stores/auth_store.dart';
import 'package:kolayca_teslimat/stores/package_store.dart';
import 'package:kolayca_teslimat/stores/theme_store.dart';
import 'package:mobx/mobx.dart';

part 'root_store.g.dart';

class RootStore = _RootStore with _$RootStore;

abstract class _RootStore with Store {
  @observable
  late ThemeStore themeStore;
  @observable
  late AuthStore authStore;
  @observable
  late PackageStore packageStore;

  _RootStore(
      {required this.themeStore,
      required this.authStore,
      required this.packageStore});
}
