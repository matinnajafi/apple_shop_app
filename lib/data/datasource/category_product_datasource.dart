import 'package:apple_shop_app/data/model/product.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICategoryProductDatasource {
  Future<List<Product>> getProductsByCategoryId(String category);
}

class CategoryProductRemoteDatasource extends ICategoryProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'category="$categoryId"'};

      Response<dynamic> response;

      // if category is all , show all products
      if (categoryId == 'qnbj8d6b9lzzpn8') {
        response = await _dio.get(
          'collections/products/records',
        ); // without queryParameters cause we want all products
      } else {
        response = await _dio.get(
          'collections/products/records',
          queryParameters: qParams,
        );
      }

      return (response.data['items'] as List)
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.data['code'],
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
