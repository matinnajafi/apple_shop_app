import 'package:apple_shop_app/bloc/product/product_event.dart';
import 'package:apple_shop_app/bloc/product/product_state.dart';
import 'package:apple_shop_app/data/repository/product_detail_repository.dart';
import 'package:apple_shop_app/data/repository/product_repository.dart';
import 'package:bloc/bloc.dart';

import '../../di/di.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IDetailProductRepository _productDetailRepository = locator.get();
  final IProductRepository _productRepository = locator.get();

  ProductBloc() : super(ProductInitState()) {
    on<ProductDetailInitialEvent>((event, emit) async {
      emit(ProductDetailLoadingState());

      var productImages = await _productDetailRepository.getProuctImage(
        event.productId,
      );

      var productVariant = await _productDetailRepository.getProductVarinats(
        event.productId,
      );

      var productCategory = await _productDetailRepository.getProductCategory(
        event.categoryId,
      );

      var productName = await _productRepository.getProductName(
        event.productName,
      );

      var productProperties = await _productDetailRepository
          .getProductProperties(event.productId);

      emit(
        ProductDetailResponseState(
          productImages,
          productVariant,
          productCategory,
          productName,
          productProperties,
        ),
      );
    });
  }
}
