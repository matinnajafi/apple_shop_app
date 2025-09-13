import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/data/model/product.dart';
import 'package:apple_shop_app/data/model/productImage.dart';
import 'package:apple_shop_app/data/model/product_property.dart';
import 'package:apple_shop_app/data/model/product_variant.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<Productimage>> productImages;
  Either<String, List<ProductVarint>> productVariant;
  Either<String, Category> productCategory;
  Either<String, Product> productName;
  Either<String, List<ProductProperty>> productProperties;

  ProductDetailResponseState(
    this.productImages,
    this.productVariant,
    this.productCategory,
    this.productName,
    this.productProperties,
  );
}
