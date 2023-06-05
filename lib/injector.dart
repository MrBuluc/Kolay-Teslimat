import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kolayca_teslimat/network/auth_service.dart';
import 'package:kolayca_teslimat/network/package_service.dart';
import 'package:kolayca_teslimat/stores/auth_store.dart';
import 'package:kolayca_teslimat/stores/package_store.dart';
import 'package:kolayca_teslimat/stores/root_store.dart';
import 'package:kolayca_teslimat/stores/theme_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt serviceLocator = GetIt.instance;

Future init() async {
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerFactory(() => AuthStore());
  serviceLocator.registerFactory(() => ThemeStore());
  serviceLocator.registerFactory(() => PackageStore());

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  Dio dio = serviceLocator.get<Dio>();
  dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    if (sharedPreferences.containsKey("TOKEN")) {
      options.headers.putIfAbsent("Authorization",
          () => "Bearer ${sharedPreferences.getString("TOKEN") ?? ""}");
    }

    return handler.next(options);
  }));

  serviceLocator
      .registerLazySingleton(() => AuthService(serviceLocator.get<Dio>()));
  serviceLocator
      .registerLazySingleton(() => PackageService(serviceLocator.get<Dio>()));
  serviceLocator.registerLazySingleton(() => RootStore(
      authStore: serviceLocator.get<AuthStore>(),
      packageStore: serviceLocator.get<PackageStore>(),
      themeStore: serviceLocator.get<ThemeStore>()));
}
