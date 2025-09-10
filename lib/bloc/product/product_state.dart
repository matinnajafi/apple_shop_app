import 'package:apple_shop_app/data/model/productImage.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<Productimage>> getProductImage;
  ProductResponseState(this.getProductImage);
}
