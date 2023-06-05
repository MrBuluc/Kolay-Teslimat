import 'package:kolayca_teslimat/injector.dart';
import 'package:kolayca_teslimat/models/user_model.dart';
import 'package:kolayca_teslimat/network/auth_service.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  UserModel? user;

  final AuthService authService = serviceLocator.get<AuthService>();

  @computed
  bool get isLoggedIn => user != null;

  @action
  Future login(String phoneNumber) async {
    try {
      UserModel userModel = await authService.login(phoneNumber);
      (await SharedPreferences.getInstance()).setString(
        "TOKEN",
        userModel.token,
      );
      user = userModel;
    } catch (e) {
      throw Exception("Login failed");
    }
  }

  @action
  logout() {
    user = null;
  }

  @observable
  String? firstName;

  @observable
  String? lastName;

  @observable
  String? phoneNo;
}
