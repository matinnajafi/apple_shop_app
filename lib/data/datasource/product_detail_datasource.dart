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
  Future<List<Variant>> getVariant();
  Future<List<ProductVarint>> getProductVariants();
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
  Future<List<Variant>> getVariant() async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="at0y1gm0t65j62j"'};

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
  Future<List<ProductVarint>> getProductVariants() async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariant();

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
}
