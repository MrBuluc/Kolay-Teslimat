import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:kolayca_teslimat/models/package_model.dart';
import 'package:kolayca_teslimat/network/api.dart';

class PackageService {
  final Dio dio;

  PackageService(this.dio);

  Future<List<PackageModel>> getPackages() async {
    try {
      Response response = await dio.get(API.getUrl("get-filter-packages"));

      return (response.data["packages"] as List).map((json) {
        return PackageModel.fromJson(json);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<PackageModel> moveToCar(int packageId) async {
    try {
      Response response = await dio.put(API.getUrl("move-to-car"),
          queryParameters: {"packageId": packageId});
      return PackageModel.fromJson(response.data["package"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PackageRouteModel>> routing(num latitude, num longitude) async {
    try {
      Response response = await dio.get(API.getUrl("route"),
          queryParameters: {"latitude": latitude, "longitude": longitude});

      return (response.data["responses"] as List)
          .map((json) => PackageRouteModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<PackageModel> complete(int packageId, XFile file) async {
    try {
      Response response = await dio.post(API.getUrl("package-complete"),
          queryParameters: {"packageId": packageId},
          data: FormData.fromMap(
              {"photo": await MultipartFile.fromFile(file.path)}));
      return PackageModel.fromJson(response.data["package"]);
    } catch (e) {
      rethrow;
    }
  }
}
