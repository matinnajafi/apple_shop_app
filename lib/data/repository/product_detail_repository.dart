import 'package:apple_shop_app/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop_app/data/model/productImage.dart';
import 'package:apple_shop_app/data/model/product_variant.dart';
import 'package:apple_shop_app/data/model/variant_type.dart';
import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class IDetailProductRepository {
  Future<Either<String, List<Productimage>>> getProuctImage();

  Future<Either<String, List<VariantType>>> getVariantTypes();

  Future<Either<String, List<ProductVarint>>> getProductVarinats();
}

class DetailProductRepository extends IDetailProductRepository {
  final IDetailProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Productimage>>> getProuctImage() async {
    try {
      var response = await _datasource.getGallery();
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
  Future<Either<String, List<ProductVarint>>> getProductVarinats() async {
    try {
      var response = await _datasource.getProductVariants();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
