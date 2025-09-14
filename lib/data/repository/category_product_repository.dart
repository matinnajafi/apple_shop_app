import 'package:apple_shop_app/data/datasource/category_product_datasource.dart';
import 'package:apple_shop_app/data/model/product.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductsByCategoryId(
    String category,
  );
}

class CategoryProductRepository extends ICategoryProductRepository {
  final ICategoryProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProductsByCategoryId(
    String category,
  ) async {
    try {
      var response = await _datasource.getProductsByCategoryId(category);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطایی در دریافت داده ها رخ داده!');
    } catch (ex) {
      return left('خطایی در دریافت داده ها رخ داده!');
    }
  }
}
