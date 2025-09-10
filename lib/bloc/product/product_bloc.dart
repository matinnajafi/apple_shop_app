import 'package:apple_shop_app/bloc/product/product_event.dart';
import 'package:apple_shop_app/bloc/product/product_state.dart';
import 'package:apple_shop_app/data/repository/product_detail_repository.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productRepository = locator.get();
  ProductBloc() : super(ProductInitState()) {
    on<ProductDetailInitialEvent>((state, emit) async {
      emit(ProductLoadingState());
      var productImage = await _productRepository.getProductImages();
      emit(ProductResponseState(productImage));
    });
  }
}
