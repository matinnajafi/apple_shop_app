import 'package:apple_shop_app/data/model/banner.dart'
    as banner; // Import the Banner class with a prefix
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDatasource {
  Future<List<banner.BannerImage>> getBanners();
}

class BannerRemoteDatasource extends IBannerDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<banner.BannerImage>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return (response.data['items'] as List)
          .map<banner.BannerImage>(
            (jsonObject) => banner.BannerImage.fromMapJson(jsonObject),
          )
          .toList();
    } on DioError catch (ex) {
      throw ApiException(
        ex.response?.data['code'],
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
