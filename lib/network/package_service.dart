import 'package:dio/dio.dart';
import 'package:kolayca_teslimat/models/package_model.dart';
import 'package:kolayca_teslimat/network/api.dart';

class PackageService {
  final Dio dio;

  PackageService(this.dio);

  Future<List<PackageModel>> getPackages() async {
    try {
      Response response = await dio.get(API.getUrl("packages"));

      return (response.data["packages"] as List)
          .map((row) => PackageModel.fromJson(row))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<PackageModel> moveToCar(int packageId) async {
    try {
      Response response =
          await dio.put(API.getUrl("packages/show/$packageId/move-to-car"));
      return PackageModel.fromJson(response.data["package"]);
    } catch (e) {
      rethrow;
    }
  }
}
