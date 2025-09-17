import 'package:apple_shop_app/data/model/basket_item.dart';
import 'package:dartz/dartz.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<BasketItem>> basketItemList;
  BasketDataFetchedState(this.basketItemList);
}
