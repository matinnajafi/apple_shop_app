import 'package:apple_shop_app/data/model/product.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryProductState {}

class CategoryProductLoadingState extends CategoryProductState {}

class CategoryProductResponseState extends CategoryProductState {
  Either<String, List<Product>> productListByCategory;
  CategoryProductResponseState(this.productListByCategory);
}
