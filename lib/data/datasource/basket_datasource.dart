import 'package:apple_shop_app/data/model/basket_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDatasource {
  Future<void> addProductToBasket(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItems();
}

class BasketLocalDatasource extends IBasketDatasource {
  var box = Hive.box<BasketItem>('BasketBox');
  @override
  Future<void> addProductToBasket(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async {
    return box.values.toList();
  }
}
