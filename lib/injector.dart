import 'package:get_it/get_it.dart';
import 'package:kolayca_teslimat/stores/auth_store.dart';
import 'package:kolayca_teslimat/stores/package_store.dart';
import 'package:kolayca_teslimat/stores/root_store.dart';
import 'package:kolayca_teslimat/stores/theme_store.dart';

GetIt serviceLocator = GetIt.instance;

Future init() async {
  serviceLocator.registerFactory(() => AuthStore());
  serviceLocator.registerFactory(() => ThemeStore());
  serviceLocator.registerFactory(() => PackageStore());

  serviceLocator.registerLazySingleton(() => RootStore(
      authStore: serviceLocator.get<AuthStore>(),
      packageStore: serviceLocator.get<PackageStore>(),
      themeStore: serviceLocator.get<ThemeStore>()));
}
