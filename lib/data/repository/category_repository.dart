import 'package:apple_shop_app/data/datasource/category_datasource.dart';
import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:dartz/dartz.dart';
// Removed unnecessary import to avoid type conflict

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطایی در دریافت داده ها رخ داده!');
    } catch (ex) {
      return left('خطایی در دریافت داده ها رخ داده!');
    }
  }
}
