import 'package:dio/dio.dart';
import 'package:kolayca_teslimat/models/user_model.dart';
import 'package:kolayca_teslimat/network/api.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<UserModel> login(String phoneNumber) async {
    try {
      Response response = await dio
          .post(API.getUrl("login"), data: {"phoneNumber": phoneNumber});

      return UserModel.fromJson(response.data["user"]);
    } catch (e) {
      rethrow;
    }
  }
}
