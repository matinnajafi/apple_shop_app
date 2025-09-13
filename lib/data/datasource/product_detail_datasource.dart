import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/data/model/productImage.dart';
import 'package:apple_shop_app/data/model/product_variant.dart';
import 'package:apple_shop_app/data/model/variant.dart';
import 'package:apple_shop_app/data/model/variant_type.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:dio/dio.dart';

import '../../util/api_exception.dart';

abstract class IDetailProductDatasource {
  Future<List<Productimage>> getGallery(String productId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariant(String productId);
  Future<List<ProductVarint>> getProductVariants(String productId);
  Future<Category> getProductCategory(String categoryId);
}

class DetailProductRemoteDatasource extends IDetailProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Productimage>> getGallery(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
      var respones = await _dio.get(
        'collections/gallery/records',
        queryParameters: qParams,
      );

      return respones.data['items']
          .map<Productimage>(
            (jsonObject) => Productimage.fromMapJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var respones = await _dio.get('collections/variants_type/records');

      return respones.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromjson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Variant>> getVariant(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};

      var respones = await _dio.get(
        'collections/variants/records',
        queryParameters: qParams,
      );

      return respones.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<ProductVarint>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariant(productId);

    List<ProductVarint> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        var variant =
            variantList
                .where((element) => element.typeId == variantType.id)
                .toList();
        productVariantList.add(ProductVarint(variantType, variant));
      }

      return productVariantList;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<Category> getProductCategory(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$categoryId"'};
      var response = await _dio.get(
        'collections/category/records',
        queryParameters: qParams,
      );
      return Category.fromMapJson(response.data['items'][0]);
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
