import 'package:kolayca_teslimat/models/user_model.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  UserModel? user;

  @computed
  bool get isLoggedIn => user != null;

  @action
  login(String phoneNo) {
    if (phoneNo == "123456") {
      user =
          UserModel(firstName: "Hakkıcan", lastName: "Bülüç", phoneNo: phoneNo);
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
