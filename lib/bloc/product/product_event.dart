abstract class ProductEvent {}

class ProductDetailInitialEvent extends ProductEvent {
  String productId;
  ProductDetailInitialEvent(this.productId);
}
