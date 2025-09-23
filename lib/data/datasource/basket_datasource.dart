import 'package:apple_shop_app/data/model/basket_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDatasource {
  Future<void> addProductToBasket(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
  Future<void> removeProductFromBasket(int index);
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

  @override
  Future<int> getBasketFinalPrice() async {
    var productList = box.values.toList();
    var finalPrice = productList.fold(
      0,
      (accumulator, product) => accumulator + product.realPrice!,
    );

    return finalPrice;
  }

  @override
  Future<void> removeProductFromBasket(int index) async {
    box.deleteAt(index);
  }
}
