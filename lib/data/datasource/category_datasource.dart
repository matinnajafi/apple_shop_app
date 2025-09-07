import 'package:apple_shop_app/data/model/category.dart'
    as category; // Import the Category class with a prefix
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICategoryDatasource {
  Future<List<category.Category>> getCategories();
}

class CategoryRemoteDatasource extends ICategoryDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<category.Category>> getCategories() async {
    try {
      var response = await _dio.get('collections/category/records');
      return (response.data['items'] as List)
          .map<category.Category>(
            (jsonObject) => category.Category.fromMapJson(jsonObject),
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
