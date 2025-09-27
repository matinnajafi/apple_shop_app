import 'package:apple_shop_app/data/model/product.dart';

abstract class BasketEvent {}

// buy from basket
class BasketFetchFromHiveEvent extends BasketEvent {}

class BasketPaymentInitEvent extends BasketEvent {}

class BasketPaymentRequestEvent extends BasketEvent {}

class BasketRemoveProductEvent extends BasketEvent {
  int index;
  BasketRemoveProductEvent(this.index);
}

// buy single item
class ProductPaymentInitEvent extends BasketEvent {
  Product product;
  ProductPaymentInitEvent(this.product);
}

class ProductPaymentRequestEvent extends BasketEvent {}
