import 'package:apple_shop_app/bloc/categoryProduct/category_product_event.dart';
import 'package:apple_shop_app/bloc/categoryProduct/category_product_state.dart';
import 'package:apple_shop_app/data/repository/category_product_repository.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:bloc/bloc.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository _repository = locator.get();

  CategoryProductBloc() : super(CategoryProductLoadingState()) {
    on<CategoryProductInitialize>((event, emit) async {
      var response = await _repository.getProductsByCategoryId(
        event.categoryId,
      );
      emit(CategoryProductResponseState(response));
    });
  }
}
