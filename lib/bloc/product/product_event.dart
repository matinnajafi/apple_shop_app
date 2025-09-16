import 'package:apple_shop_app/data/model/product.dart';

abstract class ProductEvent {}

class ProductDetailInitialEvent extends ProductEvent {
  String productId;
  String categoryId;
  String productName;

  ProductDetailInitialEvent(this.productId, this.categoryId, this.productName);
}

class AddProductToBasketEvent extends ProductEvent {
  Product product;
  AddProductToBasketEvent(this.product);
}
