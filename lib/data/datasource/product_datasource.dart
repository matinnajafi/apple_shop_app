import 'package:apple_shop_app/data/model/product.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDatasource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getHotest();
  Future<List<Product>> getBestSeller();
  Future<Product> getProductName(String productName);
}

class ProductRemoteDatasource extends IProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');
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

  @override
  Future<List<Product>> getBestSeller() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity="Hotest"'};
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );
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

  @override
  Future<List<Product>> getHotest() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity="Best Seller"'};
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );
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

  @override
  Future<Product> getProductName(String productName) async {
    try {
      Map<String, String> qParams = {'filter': 'name="$productName"'};
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );
      return Product.fromMapJson(response.data['items'][0]);
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
