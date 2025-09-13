abstract class ProductEvent {}

class ProductDetailInitialEvent extends ProductEvent {
  String productId;
  String categoryId;
  String productName;

  ProductDetailInitialEvent(this.productId, this.categoryId, this.productName);
}
