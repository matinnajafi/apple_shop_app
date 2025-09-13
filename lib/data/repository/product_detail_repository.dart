import 'package:apple_shop_app/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/data/model/productImage.dart';
import 'package:apple_shop_app/data/model/product_variant.dart';
import 'package:apple_shop_app/data/model/variant_type.dart';
import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class IDetailProductRepository {
  Future<Either<String, List<Productimage>>> getProuctImage(String productId);

  Future<Either<String, List<VariantType>>> getVariantTypes();

  Future<Either<String, List<ProductVarint>>> getProductVarinats(
    String productId,
  );
  Future<Either<String, Category>> getProductCategory(String categoryId);
}

class DetailProductRepository extends IDetailProductRepository {
  final IDetailProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Productimage>>> getProuctImage(
    String productId,
  ) async {
    try {
      var response = await _datasource.getGallery(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantTypes() async {
    try {
      var response = await _datasource.getVariantTypes();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductVarint>>> getProductVarinats(
    String productId,
  ) async {
    try {
      var response = await _datasource.getProductVariants(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      var response = await _datasource.getProductCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
