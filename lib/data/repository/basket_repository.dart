import 'package:apple_shop_app/data/datasource/basket_datasource.dart';
import 'package:apple_shop_app/data/model/basket_item.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
}

class BasketRepository extends IBasketRepository {
  final IBasketDatasource _datasource = locator.get();
  @override
  Future<Either<String, String>> addProductToBasket(
    BasketItem basketItem,
  ) async {
    try {
      _datasource.addProductToBasket(basketItem);
      return right('محصول به سبد اضافه شد');
      // ignore: unused_catch_clause
    } on ApiException catch (ex) {
      return left('محصول به سبد اضافه نشد!');
    } catch (ex) {
      return left('خطایی در دریافت داده ها رخ داده!');
    }
  }
}
